import 'dart:math';
import 'package:carpool/view/main_container.dart';
import 'package:flutter/material.dart';
import '../classes_updated/user_class.dart';
import '../firebase/authentication.dart';

class SignUpController {
  static void registerUser(
      context, fullName, email, password, phoneNumber) async {
    // Call the Firebase instance method here
    String? error = await Authentication.instance
        .createUserWithEmailAndPassword(fullName, email, password, phoneNumber);

    
    if (error == null) {
      // Navigate to the home page on success
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("SUCCESSFUL")),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNavPage()),
      );
      Authentication.instance.getCurrentUser(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
      // Display error message on failure
    }
  }
}
