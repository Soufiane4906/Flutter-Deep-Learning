import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/pages/home_page.dart';
import 'package:flutter_project/pages/login_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyAr5m5MRNgNHMjG9-eH997z-KEoGb8oHeY',
            appId: '1:309638807640:web:22a38fcc2ea0fcab568a2d',
            messagingSenderId: '309638807640',
            projectId: 'flutterproject-5305a',
            authDomain: 'flutterproject-5305a.firebaseapp.com',
            storageBucket: 'flutterproject-5305a.firebasestorage.app'));
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Hub',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.deepPurple.shade50,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepPurple.shade300,
          elevation: 5,
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.grey.shade700),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.deepPurple.shade300,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      home: HomePage(name: 'Guest User', email: 'guest@example.com'),
    );
  }
}