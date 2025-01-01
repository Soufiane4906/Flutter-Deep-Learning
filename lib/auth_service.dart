import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> createUserWithEmailAndPassword(String email, String password, String name) async {
    try {
      final UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = cred.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
          'imageUrl': 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fvaibhavji.medium.com%2Fdeep-learning-in-android-using-tensorflow-lite-with-flutter-f6e18994748&psig=AOvVaw00O8x3_frBiEo_LtO5tSQx&ust=1735834704313000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCNCB4Kn21IoDFQAAAAAdAAAAABAE',
        });
      }
      return user;
    } catch (e) {
      log("Something went wrong: ${e.toString()}");
    }
    return null;
  }

  Future<User?> loginUserWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return cred.user;
    } catch (e) {
      log("Something went wrong: ${e.toString()}");
    }
    return null;
  }

  Future<void> signout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("Something went wrong: ${e.toString()}");
    }
  }

  Future<String?> uploadProfileImage(File image) async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        final ref = _storage.ref().child('profile_images').child('${user.uid}.jpg');
        await ref.putFile(image);
        final imageUrl = await ref.getDownloadURL();
        await _firestore.collection('users').doc(user.uid).update({'imageUrl': imageUrl});
        return imageUrl;
      }
    } catch (e) {
      log("Something went wrong: ${e.toString()}");
    }
    return null;
  }

  Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        final doc = await _firestore.collection('users').doc(user.uid).get();
        return doc.data();
      }
    } catch (e) {
      log("Something went wrong: ${e.toString()}");
    }
    return null;
  }
}