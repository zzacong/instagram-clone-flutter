import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String postId;
  final String description;
  final String uid;
  final String username;
  final DateTime datePublished;
  final String postUrl;
  final String profileImage;
  final List likes;

  const Post({
    required this.description,
    required this.uid,
    required this.username,
    required this.datePublished,
    required this.postUrl,
    required this.profileImage,
    required this.likes,
    required this.postId,
  });

  Map<String, dynamic> toJson() => {
        'postId': postId,
        'description': description,
        'uid': uid,
        'username': username,
        'datePublished': datePublished,
        'postUrl': postUrl,
        'profileImage': profileImage,
        'likes': likes,
      };

  static Post fromSnap(DocumentSnapshot snapshot) {
    final docData = snapshot.data() as Map<String, dynamic>;
    return Post(
      postId: snapshot.id,
      description: docData['description'],
      uid: docData['uid'],
      username: docData['username'],
      datePublished: (docData['datePublished'] as Timestamp).toDate(),
      postUrl: docData['postUrl'],
      profileImage: docData['profileImage'],
      likes: docData['likes'],
    );
  }
}
