import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_flutter/resources/storage_methods.dart';

class AuthMethods {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<String> signUp({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty) {
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        // print(cred.user.toString());

        String photoUrl = await StorageMethods.uploadImageToStorage(
            'profile_pics', file, false);

        // add user to database
        await _firestore.doc('users/${cred.user!.uid}').set({
          'username': username,
          'email': email,
          'uid': cred.user!.uid,
          'bio': bio,
          'followers': [],
          'following': [],
          'photoUrl': photoUrl,
        });

        return 'success';
      }
      return 'invalid fields';
    } catch (error) {
      print(error);
      return error.toString();
    }
  }
}
