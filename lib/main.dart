import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stridesync_ui/createPost.dart';
import 'package:stridesync_ui/login.dart';
import 'package:stridesync_ui/user_landing.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyC4q0ZHrYo6lwBs0OOH1t_ZGADSotJfjIM",
        appId: "1:428070319156:web:8ebacaff969ae4a3d24661",
        messagingSenderId: "428070319156",
        projectId: "stridesync-2ded9",
        storageBucket: "stridesync-2ded9.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  try {
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    // print connected to emulator
    debugPrint('Connected to the Firebase Emulator Suite');
  } catch (e) {
    // ignore: avoid_print
    print(e);
  }
  runApp(ChangeNotifierProvider(
    create: (context) => PostListModel(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: HomePage(),
        routes: {
          "/": (context) => const HomePage(),
          "/landing": (context) => const UserLanding(),
          "/createPost": (context) => const CreatePost(),
        });
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              // StrideSync & Sign Up
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RawMaterialButton(
                    onPressed: () {},
                    child: const DefaultTextStyle(
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.w400),
                      child: Text("Sign Up"),
                    ),
                  ),
                ),
              ],
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Just finished running? Let's see how you looked.",
                                style: TextStyle(
                                    fontSize: 28.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                                maxLines: 3,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Keep track of your runs. Visualize your form. Evaluate your performance.",
                                style: TextStyle(
                                    fontSize: 24.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                                maxLines: 4,
                              ),
                            ])),
                  ),
                  Image.asset("assets/user_running.png"),
                ]),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF660033),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  minimumSize: const Size(200, 36),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: const Text("Log In",
                    style: TextStyle(
                      fontSize: 18.0,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
