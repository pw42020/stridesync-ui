/// screen for post video, author, title, description, date posted
///

import 'package:flutter/material.dart';
import 'package:stridesync_ui/components/post.dart';
import 'package:stridesync_ui/secondsMinutesHoursDaysAgo.dart';
import 'package:video_player/video_player.dart';

class PostScreen extends StatefulWidget {
  final Post post;
  const PostScreen({Key? key, required this.post}) : super(key: key);

  @override
  PostScreenState createState() => PostScreenState();
}

class PostScreenState extends State<PostScreen> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    // print(widget.post.videoLink!);
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.post.videoLink!),
    );
    _controller!.initialize().then((_) {
      _controller!.play();
      _controller!.setLooping(true);
      setState(() {});
    });
  }

  _showVideo(constraints) {
    return Center(
        child: Expanded(
            flex: 1,
            child: SizedBox(
                height: constraints.maxHeight * 0.7,
                width: constraints.maxHeight * 0.7,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 1,
                          child: SizedBox(
                            child: VideoPlayer(_controller!),
                          )),
                      const SizedBox(height: 10),
                      VideoProgressIndicator(_controller!,
                          allowScrubbing: true,
                          colors: const VideoProgressColors(
                              playedColor: Colors.red,
                              bufferedColor: Colors.grey,
                              backgroundColor: Colors.black)),
                      const SizedBox(height: 10),
                      ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Color(0xFF660033)),
                          ),
                          onPressed: () => {
                                if (_controller!.value.isPlaying)
                                  {_controller!.pause(), setState(() {})}
                                else
                                  {_controller!.play(), setState(() {})}
                              },
                          child: _controller!.value.isPlaying
                              ? const Icon(Icons.pause, color: Colors.white)
                              : const Icon(Icons.play_arrow,
                                  color: Colors.white))
                    ]))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.post.title,
              style: const TextStyle(color: Colors.black)),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          return Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(widget.post.description),
                        Text(
                            "Posted ${secondsMinutesHoursDaysAgo(widget.post.datePosted)}"),
                        // Text(post.runFileUrl),
                        // video player
                        if (_controller != null)
                          // get video player, video progress indicator
                          _showVideo(constraints)
                        else
                          const CircularProgressIndicator(),
                      ],
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: constraints.maxHeight * 0.45,
                              child: Image.network(widget.post.stridePlot!,
                                  fit: BoxFit.contain)),
                          const SizedBox(height: 10),
                          SizedBox(
                              height: constraints.maxHeight * 0.45,
                              child: Image.network(widget.post.cadencePlot!,
                                  fit: BoxFit.contain))
                        ]),
                  ]));
        }));
  }
}
