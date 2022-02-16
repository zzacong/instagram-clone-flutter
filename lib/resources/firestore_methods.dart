import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_flutter/models/post.dart';
import 'package:instagram_flutter/models/user.dart';
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
        'comments': 0,
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
        var postRef = _firestore.doc('posts/$postId');
        var commentsRef = _firestore.collection('posts/$postId/comments');
        await Future.wait([
          commentsRef.add({
            'text': text,
            'uid': uid,
            'username': username,
            'profilePic': profilePic,
            'datePublished': FieldValue.serverTimestamp(),
          }),
          postRef.update({'comments': FieldValue.increment(1)}),
        ]);
        return 'success';
      }
      throw Exception('invalid fields');
    } catch (error) {
      print(error);
      return error.toString();
    }
  }

  static Future<String> deletePost(String postId) async {
    try {
      var docRef = _firestore.doc('posts/$postId');
      await docRef.delete();
      return 'success';
    } catch (error) {
      print(error);
      return error.toString();
    }
  }

  static Future<User> getUser(String uid) async {
    final ref = _firestore.doc('users/$uid');
    final snap = await ref.get();
    return User.fromSnap(snap);
  }

  static Future<List<Post>> getUserPosts(String uid) async {
    final ref = _firestore.collection('posts').where('uid', isEqualTo: uid);
    final snap = await ref.get();
    return snap.docs.map(Post.fromSnap).toList();
  }

  static Future<String> _relationship(String follower, String followee,
      FieldValue Function(List<dynamic> elements) fv) async {
    try {
      final followerRef = _firestore.doc('users/$follower');
      final followeeRef = _firestore.doc('users/$followee');
      await Future.wait([
        followerRef.update({
          'following': fv([followee])
        }),
        followeeRef.update({
          'followers': fv([follower])
        }),
      ]);
      return 'success';
    } catch (error) {
      print(error);
      return error.toString();
    }
  }

  static Future<String> followUser(String follower, String followee) async {
    return _relationship(follower, followee, FieldValue.arrayUnion);
  }

  static Future<String> unfollowUser(String follower, String followee) async {
    return _relationship(follower, followee, FieldValue.arrayRemove);
  }
}
