/// create function that takes a timestamp and gets how much time ago it was

String secondsMinutesHoursDaysAgo(DateTime timestamp) {
  final now = DateTime.now();
  final difference = now
      .difference(timestamp)
      .inSeconds; // difference in seconds between now and timestamp

  if (difference < 60) {
    return "$difference seconds ago";
  } else if (difference < 3600) {
    return "${difference ~/ 60} minutes ago";
  } else if (difference < 86400) {
    return "${difference ~/ 3600} hours ago";
  } else {
    return "${difference ~/ 86400} days ago";
  }
}
