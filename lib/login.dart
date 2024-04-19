import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stridesync_ui/authgate.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signInWithPopUp() {
    try {
      _signIn();
    } catch (e) {
      // set up modal and print error
      print(e);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              content: Row(
                children: [
                  CircularProgressIndicator(),
                  Text("Downloading from StrideSync"),
                ],
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              textDirection: TextDirection.ltr,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: RichText(
                        text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Stride',
                      style: TextStyle(
                        color: Color.fromARGB(255, 126, 14, 39),
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                        text: 'Sync',
                        style: TextStyle(
                          color: Color.fromARGB(255, 7, 2, 3),
                          fontSize: 36,
                          fontWeight: FontWeight.w600,
                        ))
                  ],
                ))),
                const SizedBox(
                  height: 40,
                ),
                TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(hintText: "Email")),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Password",
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Forget Password?",
                      style: TextStyle(
                        color: Color.fromARGB(255, 126, 14, 39),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "Don\'t have an account? Sign Up",
                      style: TextStyle(
                        color: Color.fromARGB(255, 126, 14, 39),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF660033),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    minimumSize: Size(double.infinity, 40),
                  ),
                  onPressed: () => _signInWithPopUp(),
                  child: const Text("Log In",
                      style: TextStyle(
                        fontSize: 18.0,
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    print("$email, $password");
    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      print("User has successfully signed in");
      Navigator.pushNamed(context, "/landing");
    } else {
      print("Error");
    }
  }
}
