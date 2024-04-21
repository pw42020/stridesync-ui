import 'package:http/http.dart' as http;

/// Downloads the file from the StrideSync device
/// using the Python interface.
Future<int> downloadFileFromStrideSync() async {
  const String url = "http://127.0.0.1:8081/download-bluetooth";
  // fetch from url
  final response = await http.get(Uri.parse(url));
  // return the status code
  return response.statusCode;
}
