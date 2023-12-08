// import 'package:carpool/firebase_options.dart';
// import 'package:carpool/routes.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:carpool/firebase_options.dart';
import 'package:carpool/view/main_container.dart';
import 'package:carpool/view/routes_updated.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'firebase/database.dart';
import 'view/sign_in.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await DatabaseHelper.instance.checkDatabase();


  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: SignInScreen(),
    );
  }
}
