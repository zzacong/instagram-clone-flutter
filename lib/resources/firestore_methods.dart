import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  static Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        return await _firestore.doc('posts/$postId').update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      }
      return await _firestore.doc('posts/$postId').update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    } catch (error) {
      print(error);
    }
  }

  static Future<String> postComment(
    String postId,
    String text,
    String uid,
    String username,
    String profilePic,
  ) async {
    try {
      if (text.isNotEmpty) {
        var ref = _firestore.doc('posts/$postId').collection('comments');
        await ref.add({
          'text': text,
          'uid': uid,
          'username': username,
          'profilePic': profilePic,
          'datePublished': FieldValue.serverTimestamp(),
        });
        return 'success';
      }
      throw Exception('invalid fields');
    } catch (error) {
      print(error);
      return error.toString();
    }
  }
}
