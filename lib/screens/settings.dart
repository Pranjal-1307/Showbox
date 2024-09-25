import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'about_us_screen.dart'; // Import the About Us screen
import 'help_page.dart';      // Import the Help Us screen

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key}); // Added const and super.key for StatefulWidget

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  String _videoQuality = 'Auto';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
      _videoQuality = prefs.getString('videoQuality') ?? 'Auto';
    });
  }

  Future<void> _updateThemeMode(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = isDarkMode;
      prefs.setBool('isDarkMode', isDarkMode);
    });

    // Handle theme switching globally if needed
    if (isDarkMode) {
      // For example, update the app's global theme here
    } else {
      // Switch to light mode
    }
  }

  Future<void> _updateVideoQuality(String quality) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _videoQuality = quality;
      prefs.setString('videoQuality', quality);
    });
  }

  void _logOut() {
    // Implement log out logic, such as clearing user session
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color to black
      appBar: AppBar(
        title: const Text('Settings'), // const for better performance
        backgroundColor: Colors.black, // Match AppBar color with the background
      ),
      body: ListView(
        children: <Widget>[
          // Dark Mode Toggle
          SwitchListTile(
            title: const Text('Dark Mode', style: TextStyle(color: Colors.white)), // White text for visibility
            value: _isDarkMode,
            onChanged: _updateThemeMode,
            activeColor: Colors.white, // Ensure the toggle is visible
            inactiveThumbColor: Colors.grey,
          ),

          // Video Quality Picker
          ListTile(
            title: const Text('Video Quality', style: TextStyle(color: Colors.white)), // White text
            subtitle: Text(_videoQuality, style: const TextStyle(color: Colors.grey)), // Subtitle color
            onTap: () async {
              String? selectedQuality = await _showVideoQualityPicker();
              if (selectedQuality != null) {
                _updateVideoQuality(selectedQuality);
              }
            },
          ),

          // Manage Profile
          ListTile(
            title: const Text('Manage Profile', style: TextStyle(color: Colors.white)), // White text
            onTap: () {
              Navigator.of(context).pushNamed('/manageProfile');
            },
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
          ),

          // About Us
          ListTile(
            title: const Text('About Us', style: TextStyle(color: Colors.white)), // White text
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutUsScreen()), // Navigate to About Us screen
              );
            },
            trailing: const Icon(Icons.info_outline, color: Colors.white),
          ),

          // Help Us
          ListTile(
            title: const Text('Help Us', style: TextStyle(color: Colors.white)), // White text
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HelpPage()), // Navigate to Help Us screen
              );
            },
            trailing: const Icon(Icons.help_outline, color: Colors.white),
          ),

          // Log Out
          ListTile(
            title: const Text('Log Out', style: TextStyle(color: Colors.white)), // White text
            onTap: _logOut,
            trailing: const Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Future<String?> _showVideoQualityPicker() async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select Video Quality', style: TextStyle(color: Colors.white)), // White text
          backgroundColor: Colors.black, // Black background
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'Auto');
              },
              child: const Text('Auto', style: TextStyle(color: Colors.white)), // White text
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'Low');
              },
              child: const Text('Low', style: TextStyle(color: Colors.white)), // White text
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'Medium');
              },
              child: const Text('Medium', style: TextStyle(color: Colors.white)), // White text
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'High');
              },
              child: const Text('High', style: TextStyle(color: Colors.white)), // White text
            ),
          ],
        );
      },
    );
  }
}
