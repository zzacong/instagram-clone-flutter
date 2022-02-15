import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String id;
  final String text;
  final String uid;
  final String username;
  final String profilePic;
  final DateTime? datePublished;

  const Comment({
    required this.id,
    required this.text,
    required this.uid,
    required this.username,
    required this.profilePic,
    required this.datePublished,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'uid': uid,
        'username': username,
        'profilePic': profilePic,
        'datePublished': datePublished,
      };

  static Comment fromSnap(DocumentSnapshot snapshot) {
    final docData = snapshot.data() as Map<String, dynamic>;

    return Comment(
      id: snapshot.id,
      text: docData['text'],
      uid: docData['uid'],
      username: docData['username'],
      profilePic: docData['profilePic'],
      datePublished: docData['datePublished'] == null
          ? null
          : (docData['datePublished'] as Timestamp).toDate(),
    );
  }
}
