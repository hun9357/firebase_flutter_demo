import 'package:flutter/material.dart';
import 'package:login_demo/screens/register.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  // TextEditingController nameController = TextEditingController();
  final emailController = TextEditingController();
  final pwController = TextEditingController();

  navigateToDeviceScreen() {
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
      print(e);
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Welcome!",
              style: TextStyle(fontSize: 45),
            ),
            const SizedBox(height: 66),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  hintText: 'email address',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: pwController,
              obscureText: true,
              decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  hintText: 'password',
                  border: OutlineInputBorder()),
            ),
            ElevatedButton(onPressed: signIn, child: const Text('Login')),
            ElevatedButton(
                onPressed: () {
                  navigateToDeviceScreen();
                },
                child: const Text('Sign Up'))
          ],
        ),
      ),
    );
  }
}
