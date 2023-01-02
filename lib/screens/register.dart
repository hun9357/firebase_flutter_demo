import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_demo/screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_demo/screens/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  Future navigateToAdd(uid) async {
    print(uid);
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => additionalPage(uid)));
  }

  final emailController = TextEditingController();
  final pwController = TextEditingController();
  var uid;

  Future createUser() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text, password: pwController.text)
        .then((value) async => uid = value.user?.uid);
    await FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .set({'first_name': 'random', 'last_name': 'random'});
    return uid;
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
              Text("Create your password", style: TextStyle(fontSize: 25)),
              SizedBox(
                height: 55,
              ),
              Text('Your password must be at least 6 characters'),
              SizedBox(
                height: 55,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  hintText: 'enter your e-mail address',
                ),
              ),
              TextField(
                controller: pwController,
                decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  hintText: 'Enter your password',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  hintText: 'Confirm your password',
                ),
              ),
              Text('By signing up you agree to our Term'),
              Text('and conditions of use'),
              ElevatedButton(
                  onPressed: () async {
                    uid = await createUser();
                    await navigateToAdd(uid);
                  },
                  child: Text('Continue ->'))
            ],
          ),
        ));
  }
}

class additionalPage extends StatefulWidget {
  var uid;
  additionalPage(this.uid);
  @override
  State<additionalPage> createState() => _additionalPage(this.uid);
}

class _additionalPage extends State<additionalPage> {
  var uid;
  _additionalPage(this.uid);
  navigateToHome() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  Future setName(uid) async {
    print(uid);
    var data = await FirebaseFirestore.instance
        .collection("User")
        .doc(uid)
        .update(
            {'first_name': fnController.text, 'last_name': lnController.text});
  }

  final fnController = TextEditingController();
  final lnController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
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
            'Personal Information',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Enter your informations", style: TextStyle(fontSize: 25)),
              SizedBox(
                height: 55,
              ),
              TextField(
                controller: fnController,
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'enter your first name',
                ),
              ),
              TextField(
                controller: lnController,
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Enter your last name',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  hintText: 'Confirm your password',
                ),
              ),
              Text('By signing up you agree to our Term'),
              Text('and conditions of use'),
              ElevatedButton(
                  onPressed: () {
                    setName(uid);
                    navigateToHome();
                  },
                  child: const Text('Submit'))
            ],
          ),
        ),
      );
}
