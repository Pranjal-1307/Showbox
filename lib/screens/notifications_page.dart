import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample notifications list
    final List<String> notifications = [
      'New comment on your post',
      'Your order has been shipped',
      'Reminder: Meeting at 3 PM',
      'New follower: John Doe',
      'Password change successful',
      'Update available for the app',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        color: Colors.black,
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              title: Text(
                notifications[index],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              leading: const Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              tileColor: Colors.grey[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            );
          },
        ),
      ),
    );
  }
}
