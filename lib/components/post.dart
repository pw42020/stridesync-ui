/// post object and rendering
///

import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  final String title;
  final String description;
  // final String imageUrl;
  // final String movieUrl;
  final String id;
  final String author;

  const Post({
    Key? key,
    required this.title,
    required this.description,
    // required this.imageUrl,
    // required this.movieUrl,
    required this.id,
    required this.author,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          // Image.network(imageUrl),
          Text(title),
          // Text(description),
          // Text(movieUrl),
          // Text(author),
        ],
      ),
    );
  }
}
