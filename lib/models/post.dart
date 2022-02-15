import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String description;
  final String uid;
  final String username;
  final String postUrl;
  final String profileImage;
  final DateTime datePublished;
  final List<String> likes;
  final int comments;

  const Post({
    required this.id,
    required this.description,
    required this.uid,
    required this.username,
    required this.datePublished,
    required this.postUrl,
    required this.profileImage,
    required this.likes,
    required this.comments,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
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
      id: snapshot.id,
      description: docData['description'],
      uid: docData['uid'],
      username: docData['username'],
      postUrl: docData['postUrl'],
      profileImage: docData['profileImage'],
      datePublished: (docData['datePublished'] as Timestamp).toDate(),
      likes: List.from(docData['likes']),
      comments: docData['comments'],
    );
  }
}
