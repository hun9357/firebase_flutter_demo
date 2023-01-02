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
  //navitage to additional info page with passing uid parameter
  Future navigateToAdd(uid) async {
    print(uid);
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => additionalPage(uid)));
  }

  final emailController = TextEditingController();
  final pwController = TextEditingController();
  var uid;

  //create user using firebase auth and create user info based on firebase auth uid
  Future createUser() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: pwController.text)
          .then((value) async => uid = value.user?.uid);
      await FirebaseFirestore.instance
          .collection('User')
          .doc(uid)
          .set({'first_name': 'random', 'last_name': 'random'});
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
            child: Text('Please enter all informations'),
          ),
        ),
      ));
    }
    return uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
              SizedBox(
                height: 55,
                child: Text("Create your password",
                    style: TextStyle(fontSize: 25)),
              ),
              SizedBox(
                height: 55,
                child: Text('Your password must be at least 6 characters'),
              ),
              SizedBox(
                width: 400,
                height: 55,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: 'enter your e-mail address',
                  ),
                ),
              ),
              SizedBox(
                width: 400,
                height: 55,
                child: TextField(
                  controller: pwController,
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: 'Enter your password',
                  ),
                ),
              ),
              SizedBox(
                width: 400,
                height: 55,
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: 'Confirm your password',
                  ),
                ),
              ),
              Text('By signing up you agree to our Term'),
              Text('and conditions of use'),
              ElevatedButton(
                  onPressed: () async {
                    uid = await createUser();
                    //if user successfully created
                    if (uid != null) {
                      await navigateToAdd(uid);
                    }
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

  //change default first name and last name by user input info
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
        resizeToAvoidBottomInset: false,
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
