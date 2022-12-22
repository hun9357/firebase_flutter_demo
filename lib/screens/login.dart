import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  String fullName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Welcome!",
              style: TextStyle(fontSize: 45),
            ),
            SizedBox(height: 66),
            TextField(
              decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  hintText: 'email address',
                  border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  hintText: 'password',
                  border: OutlineInputBorder()),
            ),
            ElevatedButton(onPressed: () {}, child: Text('Login')),
            ElevatedButton(onPressed: () {}, child: Text('Sign Up'))
          ],
        ),
      ),
    );
  }
}
