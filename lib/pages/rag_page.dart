import 'package:flutter/material.dart';

class RagPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rag Page'),
        backgroundColor: Colors.deepPurple.shade300,
      ),
      body: Center(
        child: Text(
          'Welcome to the Rag Page!',
          style: TextStyle(fontSize: 24, color: Colors.deepPurple.shade300),
        ),
      ),
    );
  }
}// TODO Implement this library.