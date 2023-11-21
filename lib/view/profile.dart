import 'package:carpool/reusable_widget.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: reusableAppBar('Profile', null),
      backgroundColor: Colors.transparent,
      body: Padding(
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
              _buildButton('Sign Out', () => null),
              const SizedBox(height: 8),
              _buildButton('Delete Account', () => null),
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
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('User Details',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            ListTile(title: Text('Name: John Doe')),
            ListTile(title: Text('Email: john.doe@eng.asu.edu.eg')),
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
