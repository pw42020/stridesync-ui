import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stridesync_ui/ui/activity.dart';

// landing.dart - user just logged in and this is what they see

class LandingPage extends StatelessWidget {
  LandingPage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context){
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: signOut, 
            icon: Icon(Icons.logout),
          )
        ],
      ),
      backgroundColor: Color.fromARGB(255, 126, 14, 39),
      body: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color: Color.fromARGB(255, 223, 211, 213),
                child: Container(
                  width: screenW * 0.5 * 0.7,
                  height: screenH * 0.9,
                )
              ),
            ]
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child:
                Text("Right side"),                
              )
            ]
          ),
        ],
      )
    );



    //   body: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: <Widget>[
    //       const Padding(
    //         padding: const EdgeInsets.all(50),
    //         child: Column(
    //           textDirection: TextDirection.ltr,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text("Hello, ",
    //             style: TextStyle(
    //                 color: Colors.white,
    //                 fontSize: 24,
    //                 fontWeight: FontWeight.w400,
    //               ),
    //             )
    //           ]
    //         ),
    //       ),

    //       Padding(
    //         padding: const EdgeInsets.only(left: 50, right: 50),
    //         child: Column(
    //           children: [
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //               children: [
    //                 Column(
    //                   children: [
    //                       const Text('Upload New',
    //                       style: TextStyle(
    //                         color: Colors.white,
    //                         fontSize: 15,
    //                         fontWeight: FontWeight.w500,
    //                       ),
    //                     ),

    //                     const SizedBox(
    //                       height: 2,
    //                     ),

    //                     ClipRRect(
    //                       borderRadius: const BorderRadius.all(Radius.circular(10)),
    //                       child: SizedBox(
    //                         width: 150,
    //                         height: 150,
    //                         child: ElevatedButton(
    //                           onPressed: () {
    //                           },
    //                           child:
    //                             const Text("+",
    //                               style: TextStyle(
    //                                 fontSize: 32,
    //                                 fontWeight: FontWeight.w500,
    //                               )
    //                             ),
    //                         ),
    //                       ),
    //                     ),                       
    //                   ],
    //                 ),

    //                 Column(
    //                   children: [
    //                     const Text('October 26, 2023',
    //                       style: TextStyle(
    //                         color: Colors.white,
    //                         fontSize: 15,
    //                         fontWeight: FontWeight.w500,
    //                       ),
    //                     ),

    //                     const SizedBox(
    //                       height: 2,
    //                     ),

    //                     ClipRRect(
    //                       borderRadius: const BorderRadius.all(Radius.circular(10)),
    //                       child: SizedBox(
    //                         width: 150,
    //                         height: 150,
    //                         child: ElevatedButton(
    //                           onPressed: () {
    //                             Navigator.push(
    //                               context,
    //                               MaterialPageRoute(builder: (context) => const Activity())
    //                             );
    //                           },
    //                           child:
    //                             const Text("this would be an image of different activities",
    //                               style: TextStyle(
    //                                 fontSize: 16,
    //                                 fontWeight: FontWeight.w500,
    //                               )
    //                             ),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),

    //                 Column(
    //                   children: [
    //                       const Text('September 19, 2023',
    //                       style: TextStyle(
    //                         color: Colors.white,
    //                         fontSize: 15,
    //                         fontWeight: FontWeight.w500,
    //                       ),
    //                     ),

    //                     const SizedBox(
    //                       height: 5,
    //                     ),

    //                     ClipRRect(
    //                       borderRadius: const BorderRadius.all(Radius.circular(10)),
    //                       child: SizedBox(
    //                         width: 150,
    //                         height: 150,
    //                         child: ElevatedButton(
    //                           onPressed: () {
    //                           },
    //                           child:
    //                             const Text("this would be an image of different activities",
    //                               style: TextStyle(
    //                                 fontSize: 16,
    //                                 fontWeight: FontWeight.w500,
    //                               )
    //                             ),
    //                         ),
    //                       ),
    //                     ),                       
    //                   ],
    //                 ),

    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ]
    //   ),
    // );
  }
}
