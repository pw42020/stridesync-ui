/// post object and rendering
///

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stridesync_ui/PostScreen.dart';
import 'package:stridesync_ui/secondsMinutesHoursDaysAgo.dart';
import 'package:stridesync_ui/user_landing.dart';

class Post extends StatefulWidget {
  final String title;
  final String description;
  final String id;
  final String author;
  final DateTime datePosted;
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

  @override
  PostState createState() => PostState();
}

class PostState extends State<Post> {
  // Image? _imageToShow;
  // @override
  // void initState() {
  //   super.initState();
  //   _imageToShow = Image.network(
  //       widget.thumbnailLink ??
  //           'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Square_gray.svg/1200px-Square_gray.svg.png',
  //       width: 100,
  //       height: 100,
  //       fit: BoxFit.cover);
  // }

  // updateImageToThumbnailLink() {
  //   setState(() {
  //     _imageToShow = Image.network(widget.thumbnailLink!,
  //         width: 100, height: 100, fit: BoxFit.cover);
  //   });
  // }

  // get device height, device width
  // double deviceHeight = MediaQuery.of(context).size.width;
  // add as listener to PostListModel

  @override
  Widget build(BuildContext context) {
    PostListModel postListModel =
        Provider.of<PostListModel>(context, listen: true);
    return GestureDetector(
        onTap: () => {
              // if thumbnail link or video link is null, show modal that says
              // video has not finished processing and return
              if (widget.thumbnailLink == null || widget.videoLink == null)
                {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          content: Row(
                            children: [
                              CircularProgressIndicator(),
                              Text("Video has not finished processing"),
                            ],
                          ),
                        );
                      }),
                }
              else
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PostScreen(post: widget);
                  })),
                }
            },
        child: Card(
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
                    widget.thumbnailLink ??
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Square_gray.svg/1200px-Square_gray.svg.png',
                    width: 100,
                    height: 100,
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
                      widget.title,
                      textAlign: TextAlign.start,
                      // make bold
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(widget.description),
                    // add amount of time ago in bottom right
                    Text(secondsMinutesHoursDaysAgo(widget.datePosted),
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
        )));
  }
}
