import 'dart:math';
import 'package:carpool/firebase/database.dart';
import 'package:carpool/view/main_container.dart';
import 'package:flutter/material.dart';
import '../firebase/authentication.dart';

class SignInController {
  static void signInUser(context, email, password) async {
    // Call the Firebase instance method here
    String? error = await Authentication.instance
        .signInWithEmailAndPassword(email, password);
    await DatabaseHelper.instance.getCurrentUser();
    
    if (error == null) {
      // Navigate to the home page on success
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("SUCCESSFUL"),
        ),
      );
      // Authentication.instance.getCurrentUser(context);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNavPage()),
      );
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
