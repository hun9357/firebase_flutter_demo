import 'package:flutter/material.dart';
import 'package:login_demo/screens/homepage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  navigateToHome() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.blue,
              )),
          title: const Text(
            'Create Account',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const TextField(
                decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: 'enter your e-mail address',
                    border: OutlineInputBorder()),
              ),
              const TextField(
                decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: 'Enter your password',
                    border: OutlineInputBorder()),
              ),
              const TextField(
                decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: 'Confirm your password',
                    border: OutlineInputBorder()),
              ),
              const Text('By signing up you agree to our Term'),
              const Text('and conditions of use'),
              ElevatedButton(
                  onPressed: () {
                    navigateToHome();
                  },
                  child: const Text('Continue ->'))
            ],
          ),
        ));
  }
}
