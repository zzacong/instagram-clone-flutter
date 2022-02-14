import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_flutter/models/user.dart' as m;
import 'package:instagram_flutter/resources/storage_methods.dart';

class AuthMethods {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// get user
  static Future<m.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.doc('users/${currentUser.uid}').get();
    return m.User.fromSnap(snap);
  }

  /// sign up
  static Future<String> signUp({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
    required String fileType,
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
            'profile_pics', file, fileType, false);

        final user = m.User(
          username: username,
          email: email,
          uid: cred.user!.uid,
          bio: bio,
          photoUrl: photoUrl,
          followers: [],
          following: [],
        );
        // add user to database
        await _firestore.doc('users/${cred.user!.uid}').set(user.toJson());

        return 'success';
      }
      return 'invalid fields';
    } catch (error) {
      print(error);
      return error.toString();
    }
  }

  /// sign in
  static Future<String> signIn({
    required String email,
    required String password,
  }) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        return 'success';
      }
      return 'invalid fields';
    } catch (error) {
      print(error);
      return error.toString();
    }
  }

  /// sign out
  static Future<String> signOut() async {
    try {
      await _auth.signOut();
      return 'success';
    } catch (error) {
      print(error);
      return error.toString();
    }
  }
}
