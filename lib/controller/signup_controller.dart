import 'dart:math';
import 'package:carpool/view/main_container.dart';
import 'package:flutter/material.dart';
import '../firebase/authentication.dart';

class SignUpController {
  static void registerUser(context, email, password) async {
    // Call the Firebase instance method here
    String? error = await Authentication.instance
        .createUserWithEmailAndPassword(email, password);

    if (error == null) {
      // Navigate to the home page on success
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("SUCCESSFUL"),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNavPage()),
      );
      Authentication.instance.getCurrentUser(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
        ),
      );
      // Display error message on failure
    }
  }
}
