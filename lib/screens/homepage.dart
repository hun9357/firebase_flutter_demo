import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
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
            const Text('Name'),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 185,
                  child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Enter your new first name')),
                ),
                SizedBox(
                  width: 185,
                  child: TextField(
                      decoration: InputDecoration(
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
                      onPressed: () {},
                      child: Text('Update First Name'),
                    )),
                SizedBox(
                    width: 185,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Update Last Name'),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
