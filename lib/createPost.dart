/// dart file to create a post
///
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  File? _file;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final file = File(result.files.single.path!);
      _file = file;
      setState(() {});
    } else {
      // User canceled the picker
      // You can show snackbar or fluttertoast
      // here like this to show warning to user
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please select file'),
      ));
    }
  }

  _submitPost() async {
    // start a modal saying creating your post
    // add .run to storage, add title, description to firestore
    // if file is null, show snackbar
    if (_file == null) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please select file'),
      ));
      return;
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                Text("Creating your post..."),
              ],
            ),
          );
        });

    // upload file to storage
    try {
      // get user's uid
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final ref =
          FirebaseStorage.instance.ref().child('runs/$uid/${_file!.path}');
      await ref.putFile(_file!);
      // add title, description to firestore
      await FirebaseFirestore.instance.collection('posts').add({
        'title': 'title',
        'author': uid,
        'description': 'description',
        'file': await ref.getDownloadURL(),
      });
      // get /users/uid, add post to user's posts
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'posts': FieldValue.arrayUnion([uid]),
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Error uploading file'),
      ));
    }
    // close modal
    Navigator.pop(context);
    // pop context again
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      return Column(
        // create portion to select .run file, title, description
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RichText(
                  text: const TextSpan(children: [
                    TextSpan(
                      text: 'Stride',
                      style: TextStyle(
                        color: Color.fromARGB(255, 126, 14, 39),
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: 'Sync',
                      style: TextStyle(
                        color: Color.fromARGB(255, 7, 2, 3),
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ]),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Title
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                  ),
                ),
                const SizedBox(height: 10),
                // Description
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                ),
                const SizedBox(height: 10),
                // Select .run file
                ElevatedButton(
                  onPressed: () => getFile(),
                  child: const Text('Select .run file'),
                ),
                const SizedBox(height: 10),
                // Submit button
                ElevatedButton(
                  onPressed: () {
                    _submitPost();
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ],
      );
    }));
  }
}
