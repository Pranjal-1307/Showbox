import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:showbox/screens/firebase_options.dart';
import 'package:showbox/screens/intro_video.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShowBox',
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const IntroVideoScreen(),
    );
  }
}
