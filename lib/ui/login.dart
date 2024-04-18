import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void signIn() async {
    showDialog(
      context: context, 
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    );

    // try to sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text, 
      password: _passwordController.text,
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch(e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        wrongEmail();
      } else if (e.code == 'wrong-password') {
        wrongPassword();
      }
    }
  }

  void wrongEmail() {
    showDialog(
      context: context, 
      builder: (context) {
        return const AlertDialog(
          title: Text("Incorrect Email"),
        );
      },
    );
  }

  void wrongPassword() {
  showDialog(
    context: context, 
    builder: (context) {
      return const AlertDialog(
        title: Text("Incorrect Password"),
      );
    },
  );
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
                    text: const TextSpan(children: [
                      TextSpan(text: 'Stride',
                        style: TextStyle(
                          color: Color.fromARGB(255, 126, 14, 39),
                          fontSize: 36,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      TextSpan(text: 'Sync',
                        style: TextStyle(
                          color: Color.fromARGB(255, 7, 2, 3),
                          fontSize: 36,
                          fontWeight: FontWeight.w600,
                        )
                      )
                    ],)
                  )
                ),

                const SizedBox(
                  height: 40,
                ),

                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "Email"
                  )
                ),
                
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

                const Text(
                  'Forget Password?',
                  style: TextStyle(
                    color: Color.fromARGB(255, 126, 14, 39),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                Container(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: SizedBox(
                      width: 315,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          signIn();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 126, 14, 39),
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}