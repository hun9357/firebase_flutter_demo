import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final Timestamp birth;

  const User(
      {this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.birth});
  toJson() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "password": password,
      "date_of_birth": birth
    };
  }
}
