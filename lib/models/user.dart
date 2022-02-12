import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String email;
  final String uid;
  final String bio;
  final String photoUrl;
  final List followers;
  final List following;

  const User({
    required this.username,
    required this.email,
    required this.uid,
    required this.bio,
    required this.photoUrl,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'uid': uid,
        'bio': bio,
        'photoUrl': photoUrl,
        'followers': [],
        'following': [],
      };

  static User fromSnap(DocumentSnapshot snapshot) {
    final docData = snapshot.data() as Map<String, dynamic>;
    return User(
      username: docData['username'],
      email: docData['email'],
      uid: docData['uid'],
      bio: docData['bio'],
      photoUrl: docData['photoUrl'],
      followers: docData['followers'],
      following: docData['following'],
    );
  }
}
