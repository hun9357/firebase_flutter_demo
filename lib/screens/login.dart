import 'package:flutter/material.dart';
import 'package:login_demo/screens/register.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  //navigate to reigster page
  navigateToRegisterScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const RegisterPage()));
  }

  //authentication
  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: pwController.text.trim());
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Container(
          padding: const EdgeInsets.all(8),
          height: 70,
          decoration: const BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: const Center(
            child: Text('Please enter correct credentials'),
          ),
        ),
      ));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 150,
              child: const Text(
                "Welcome!",
                style: TextStyle(fontSize: 45),
              ),
            ),
            SizedBox(
              height: 50,
              width: 400,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  hintText: 'email address',
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: 400,
              child: TextField(
                  controller: pwController,
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: 'password',
                  )),
            ),
            ElevatedButton(onPressed: signIn, child: const Text('Login')),
            ElevatedButton(
                onPressed: () {
                  navigateToRegisterScreen();
                },
                child: const Text('Sign Up'))
          ],
        ),
      ),
    );
  }
}
