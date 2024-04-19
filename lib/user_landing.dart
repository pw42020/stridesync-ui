import "package:flutter/material.dart";
import "package:stridesync_ui/components/post.dart";
import "package:stridesync_ui/python_interface.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

class UserLanding extends StatefulWidget {
  const UserLanding({super.key});

  @override
  State<UserLanding> createState() => _UserLandingScreen();
}

class _UserLandingScreen extends State<UserLanding> {
  final List<Post> _posts = List<Post>.empty(growable: true);

  // upon user landing screen opening, get all posts from firestore users/uid
  @override
  void initState() {
    super.initState();
    // get all posts from firestore
    // add to _posts
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        // print(doc["title"]);
        // print(doc["description"]);
        // print(doc["imageUrl"]);
        // print(doc["movieUrl"]);
        // print(doc["author"]);
        _posts.add(Post(
          author: doc["author"],
          title: doc["title"],
          description: doc["description"],
          // imageUrl: doc["imageUrl"],
          // movieUrl: doc["movieUrl"],
          id: doc.id,
        ));
      }
      print('got ${_posts.length} posts');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      return Column(
          // StrideSync & Sign Up
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
            Row(
              // Profile & Activities
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Card
                Container(
                  padding: EdgeInsets.all(10),
                  width: constraints.maxWidth * 0.3,
                  child: Column(children: [
                    Card(
                      child: SizedBox(
                          width: constraints.maxWidth * 0.3,
                          height: constraints.maxHeight * 0.25,
                          child: Center(
                            child: Text("Hello, User"),
                          )),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF660033),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        minimumSize: Size(constraints.maxWidth * 0.3, 36),
                      ),
                      onPressed: () => {
                        // creating loading modal
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AlertDialog(
                                content: Row(
                                  children: [
                                    CircularProgressIndicator(),
                                    Text("Downloading from StrideSync"),
                                  ],
                                ),
                              );
                            }),
                        downloadFileFromStrideSync().then((value) => {
                              Navigator.pop(context),
                              // state error or success
                              print('hello world')
                            })
                      },
                      child: const Text("Download from StrideSync",
                          style: TextStyle(
                            fontSize: 18.0,
                          )),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF660033),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        minimumSize: Size(constraints.maxWidth * 0.3, 36),
                      ),
                      onPressed: () => {
                        // navigate to createPost
                        Navigator.pushNamed(context, '/createPost')
                      },
                      child: const Text("Upload New Activity",
                          style: TextStyle(
                            fontSize: 18.0,
                          )),
                    ),
                  ]),
                ),

                // show the first post
                if (_posts.isNotEmpty) _posts[0],
              ],
            )
          ]);
    }));
  }
}
