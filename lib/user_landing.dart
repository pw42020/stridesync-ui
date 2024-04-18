import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";

class userLanding extends StatefulWidget {
  userLanding({super.key});

  @override
  State<userLanding> createState() => _userLandingScreen();
}

class _userLandingScreen extends State<userLanding> {

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
                      onPressed: () {},
                      child: const Text("Upload New Activity",
                          style: TextStyle(
                            fontSize: 18.0,
                          )),
                    ),
                  ]),
                ),

                Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Card(
                          child: SizedBox(
                              width: constraints.maxWidth * 0.6,
                              height: constraints.maxHeight * 0.25,
                              child: Text("Thing"))),
                      Card(
                          child: SizedBox(
                              width: constraints.maxWidth * 0.6,
                              height: constraints.maxHeight * 0.25,
                              child: Text("Thing"))),
                    ],
                  ),
                ))
              ],
            )
          ]);
    }));
  }
}
