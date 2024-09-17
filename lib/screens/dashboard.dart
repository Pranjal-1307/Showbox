import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardScreen extends StatelessWidget {
  final User user;

  DashboardScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${user.email}'), // Use the user's email or other properties
      ),
      body: Center(
        child: Text('Welcome to your dashboard, ${user.displayName ?? user.email}!'),
      ),
    );
  }
}
