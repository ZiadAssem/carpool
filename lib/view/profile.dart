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
              const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 142, 15, 6),
                radius: 100,
                child: Icon(Icons.person,size: 80,color: Colors.white,), // Set your image path
              ),
              const SizedBox(height: 16),
              Card(
                color: Colors.white.withOpacity(0.9),
                elevation: 8,
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User Details',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      ListTile(
                        title: Text('Name: John Doe'),
                      ),
                      ListTile(
                        title: Text('Email: john.doe@eng.asu.edu.eg'),
                      ),
                      // Add more user details as needed
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Handle sign-out logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 142, 15, 6),
                ),
                child: const Text('Sign Out'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  // Handle delete account logic
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 142, 15, 6)),
                child: const Text('Delete Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
