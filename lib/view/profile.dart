import 'package:carpool/classes_updated/user_class.dart' as U;
import 'package:carpool/controller/profile_controller.dart';
import 'package:carpool/firebase/authentication.dart';
import 'package:carpool/local_database/local_database.dart';
import 'package:carpool/local_database/profile_model.dart';
import 'package:carpool/reusable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carpool/firebase/database.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.isOnline}) : super(key: key);
  final isOnline;
  // final _currentUser = await DatabaseHelper.instance.getCurrentUser();
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // final _currentUser = DatabaseHelper.instance.currentUser;
  bool _isLoading = true;
  late ProfileController _controller;
  late Map<String, dynamic> _currentUserData;
  late Map<String, dynamic> userData;

  @override
  void initState() {

    _controller = ProfileController(model: ProfileModel());

    _loadUserData();
        super.initState();


  }

  Future<void> _loadUserData() async {
      Map<String, dynamic>? loadedData = await _controller.loadUserData(Authentication.instance.currentUserId);
      print(loadedData?['name'] );
    setState(() {
      userData = loadedData!;
      _isLoading = false;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reusableAppBar('Profile', null),
      backgroundColor: Colors.transparent,
      body: _isLoading? 
      const CircularProgressIndicator()
      : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCircleAvatar(),
              const SizedBox(height: 16),
              _buildDetailsCard(),
              const SizedBox(height: 16),
              _buildButton('Sign Out',
                  () => Authentication.instance.signOutUser(context)),
              const SizedBox(height: 8),
              _buildButton('Delete Account',
                  () => Authentication.instance.deleteAccount(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircleAvatar() {
    return const CircleAvatar(
      backgroundColor: Color.fromARGB(255, 142, 15, 6),
      radius: 100,
      child: Icon(
        Icons.person,
        size: 80,
        color: Colors.white,
      ), // Set your image path
    );
  }

  Widget _buildDetailsCard() {
    return Card(
      color: Colors.white.withOpacity(0.9),
      elevation: 8,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('User Details',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            ListTile(title: Text('Name: ${userData['name']}')),
            ListTile(title: Text('Email: ${userData['email']}')),
            ListTile(
              title: Text('Phone Number: ${userData['phoneNumber']}'),
            )
            // Add more user details as needed
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, Function() fnOnTap) {
    return ElevatedButton(
      onPressed: fnOnTap,
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 142, 15, 6)),
      child: Text(text),
    );
  }
}
