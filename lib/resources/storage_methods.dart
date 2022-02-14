import 'dart:typed_data';

import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // upload image to firebase storage
  static Future<String> uploadImageToStorage(
    String childName,
    Uint8List file,
    String fileType,
    bool isPost,
  ) async {
    Reference ref = _storage
        .ref()
        .child(childName)
        .child("${_auth.currentUser!.uid}${isPost ? '' : '.$fileType'}");

    if (isPost) {
      String id = const Uuid().v4();
      ref = ref.child("$id.$fileType");
    }

    UploadTask uploadTask =
        ref.putData(file, SettableMetadata(contentType: 'image/$fileType'));
    TaskSnapshot snap = await uploadTask;
    return await snap.ref.getDownloadURL();
  }
}
