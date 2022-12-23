import 'package:flutter/material.dart';
import 'package:login_demo/screens/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  String fullName = '';

  navigateToDeviceScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const RegisterPage()));
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
            const TextField(
              decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  hintText: 'email address',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  hintText: 'password',
                  border: OutlineInputBorder()),
            ),
            ElevatedButton(onPressed: () {}, child: const Text('Login')),
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
