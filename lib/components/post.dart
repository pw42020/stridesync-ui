/// post object and rendering
///

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stridesync_ui/secondsMinutesHoursDaysAgo.dart';

class Post extends StatelessWidget {
  final String title;
  final String description;
  final String id;
  final String author;
  final Timestamp datePosted;
  // final String runFileUrl;
  String? thumbnailLink;
  String? videoLink;

  Post({
    Key? key,
    required this.title,
    required this.description,
    required this.id,
    required this.author,
    required this.datePosted,
    // required this.runFileUrl,
    this.thumbnailLink,
    this.videoLink,
  }) : super(key: key);

  // get device height, device width
  // double deviceHeight = MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      padding: const EdgeInsets.all(10),
      // set width to remainder of screen
      width: MediaQuery.of(context).size.width * 0.6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        // style with padding 1% aronud
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.redAccent,
            ),
            child: Image.network(
                thumbnailLink ??
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Square_gray.svg/1200px-Square_gray.svg.png',
                width: 150,
                height: 150,
                fit: BoxFit.cover),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            // stop text from aligning in the center
            // have text start at the start
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              // make text start at the top

              children: [
                // Text(author),
                Text(
                  title,
                  textAlign: TextAlign.start,
                  // make bold
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(description),
                // add amount of time ago in bottom right
                Text(secondsMinutesHoursDaysAgo(datePosted.toDate()),
                    textAlign: TextAlign.end,
                    style: const TextStyle(fontSize: 12)),
              ],
            ),
          )
          // Text(description),
          // Text(movieUrl),
          // Text(author),
        ],
      ),
    ));
  }
}
