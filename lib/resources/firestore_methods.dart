import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_flutter/models/post.dart';
import 'package:instagram_flutter/resources/storage_methods.dart';

class FirestoreMethods {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// upload post
  static Future<String> uploadPost({
    required String description,
    required Uint8List file,
    required String fileType,
    required String uid,
    required String username,
    required String profileImage,
  }) async {
    try {
      String photoUrl = await StorageMethods.uploadImageToStorage(
          'posts', file, fileType, true);
      _firestore.collection('posts').add({
        'description': description,
        'uid': uid,
        'username': username,
        'datePublished': FieldValue.serverTimestamp(),
        'postUrl': photoUrl,
        'profileImage': profileImage,
        'likes': [],
      });

      return 'success';
    } catch (error) {
      print(error);
      return error.toString();
    }
  }
}
