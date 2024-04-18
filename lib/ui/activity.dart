import 'package:flutter/material.dart';

class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  State<Activity> createState() => _Activity();
}

class _Activity extends State<Activity> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 126, 14, 39),
        title: const Text("Activity"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              textDirection: TextDirection.ltr,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text("Length of Activity"),
                        Text("00.00"),
                      ]
                    ),
                    
                    Column(
                      children: [
                        Text("Cadence (spm)"),
                        Text("150 spm"),
                      ]
                    ),

                    Column(
                      children: [
                        Text("Something Else"),
                        Text("00.00"),
                      ]
                    ),

                  ]
                ),

                const SizedBox(
                height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 150,
                      width: 400,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 126, 14, 39),
                        ),
                        child: const Center(
                          child: Text("This is where a visual would be?"),
                        )
                      ),
                    ),
                  ]
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          // Container(
          //   alignment: Alignment.center,
          //   child:
          //     const ExpansionTile(
          //       title: Center(
          //         child: Text(
          //           "Sweat Analysis",
          //           textAlign: TextAlign.center,
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 15,
          //             fontWeight: FontWeight.w500,
          //           ),
          //         )
          //       ),
          //       collapsedBackgroundColor: Color.fromARGB(255, 126, 14, 39),
          //       backgroundColor: Color.fromARGB(255, 161, 78, 96),
          //       children: <Widget>[
          //         ListTile(
          //           title: Center(
          //             child: Text("This will be where the sweat analysis is",
          //               textAlign: TextAlign.center
          //             )
          //           )
          //         ),
          //       ],
          //     )
          // ),
        ],
      ),
    );
  }
}