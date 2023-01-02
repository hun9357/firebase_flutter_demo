import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  var userfn;
  var userln;
  //getting current user's uid
  Future getuid() async {
    //find user with same uid in cloud store
    var data = await FirebaseFirestore.instance
        .collection("User")
        .doc(user.uid)
        .snapshots()
        .listen((event) {
      setState(() {
        userfn = event.get("first_name");
        userln = event.get("last_name");
      });
    });
  }

  Future updateFn() async {
    var collection = await FirebaseFirestore.instance
        .collection('User')
        .doc(user.uid)
        .update({'first_name': fnController.text})
        .then((_) => print("updated"))
        .catchError((error) => print("Failed: " '$error'));
  }

  Future updateLn() async {
    var collection = await FirebaseFirestore.instance
        .collection('User')
        .doc(user.uid)
        .update({'last_name': lnController.text})
        .then((_) => print("updated"))
        .catchError((error) => print("Failed: " '$error'));
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  final fnController = TextEditingController();
  final lnController = TextEditingController();

  @override
  void initState() {
    getuid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Screen Example',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              color: Colors.blue,
              onPressed: signOut,
              icon: Icon(Icons.lock_open))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Firestore Example',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 10),
            const Text('we can see and update data in real time'),
            const SizedBox(height: 15),
            Text('$userfn' + " " + '$userln'),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 185,
                  child: TextField(
                      controller: fnController,
                      decoration: const InputDecoration(
                          hintText: 'Enter your new first name')),
                ),
                SizedBox(
                  width: 185,
                  child: TextField(
                      controller: lnController,
                      decoration: const InputDecoration(
                          hintText: 'Enter your new last name')),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    width: 185,
                    child: ElevatedButton(
                      onPressed: updateFn,
                      child: const Text('Update First Name'),
                    )),
                SizedBox(
                    width: 185,
                    child: ElevatedButton(
                      onPressed: updateLn,
                      child: const Text('Update Last Name'),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
