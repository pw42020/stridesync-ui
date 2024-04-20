import "package:flutter/material.dart";
import "package:stridesync_ui/components/post.dart";
import "package:stridesync_ui/python_interface.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserLanding extends StatefulWidget {
  const UserLanding({super.key});

  @override
  State<UserLanding> createState() => _UserLandingScreen();
}

class _UserLandingScreen extends State<UserLanding> {
  final List<Post> _posts = List<Post>.empty(growable: true);

  // upon user landing screen opening, get all posts from firestore users/uid
  var _loading = true;
  final User? _user = FirebaseAuth.instance.currentUser;
  final int _initNumPosts =
      5; // initial number of posts to retrieve from firestore

  _loadPosts() async {
    FirebaseFirestore.instance
        .collection('users/${_user!.uid}/posts')
        .orderBy("datePosted", descending: true)
        .limit(_initNumPosts)
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
          // runFileUrl: doc["runFileUrl"],
          datePosted: doc["datePosted"],
          id: doc.id,
          thumbnailLink: doc["thumbnailLink"],
          videoLink: doc["videoLink"],
        ));
      }
      print('got ${_posts.length} posts');
      // set _loading to false
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // get all posts from firestore
    _loadPosts();
  }
  // get user information

  // get /users/uid from firestore

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
                  padding: EdgeInsets.all(constraints.maxWidth * 0.01),
                  width: constraints.maxWidth * 0.35,
                  child: Column(children: [
                    Card(
                      child: SizedBox(
                          width: constraints.maxWidth * 0.3,
                          height: constraints.maxHeight * 0.2,
                          // padding: EdgeInsets.all(10),
                          child: Row(
                            // center the children
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: constraints.maxWidth * 0.05,
                                backgroundImage: NetworkImage(_user!.photoURL!),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _user!.displayName!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(_user!.email!),
                                  Text("Total Activities: ${_posts.length}"),
                                ],
                              ),
                            ],
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
                          textAlign: TextAlign.center,
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

                // show the first post)
                if (_loading)
                  const CircularProgressIndicator()
                else
                  Expanded(
                      flex: 1,
                      child: Container(
                          padding: EdgeInsets.only(
                              right: constraints.maxWidth * 0.01),
                          child: SizedBox(
                              height: constraints.maxHeight * 0.8,
                              child: RefreshIndicator(
                                  onRefresh: () => _loadPosts(),
                                  color: Colors.white,
                                  backgroundColor: Colors.blue,
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: _posts.length,
                                    itemBuilder: (context, index) {
                                      return _posts[index];
                                    },
                                  ))))),
                // if (_posts.isNotEmpty)
                //   Expanded(
                //       flex: 1,
                //       child: Container(
                //           padding: EdgeInsets.only(
                //               right: constraints.maxWidth * 0.01),
                //           child: SizedBox(
                //               height: constraints.maxHeight * 0.8,
                //               child: ListView.builder(
                //                 itemCount: _posts.length,
                //                 itemBuilder: (context, index) {
                //                   return _posts[index];
                //                 },
                //               ))))
                // else
                //   const Text("No posts yet"),
              ],
            )
          ]);
    }));
  }
}
