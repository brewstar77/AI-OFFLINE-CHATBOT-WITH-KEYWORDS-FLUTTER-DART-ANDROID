// In main.dart
import 'package:flutter/material.dart';
import 'pages/user.dart'; // Import the User model
import 'pages/register.dart';

// String? currentUsername; // We'll get this from currentUser now
User? currentUser; // This will hold all the user's data

// Convenience getter if your Homepage still directly uses currentUsername
String? get currentUsername => currentUser?.username;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduMate 361',
      theme: ThemeData(
        // ... your theme data ...
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo).copyWith(
          primary: Colors.indigo[700],
          onPrimary: Colors.white,
          secondary: Colors.amber,
        ),
      ),
      home: const RegistrationPage(), // Or a wrapper to decide login/register
    );
  }
}