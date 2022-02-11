import 'dart:developer' as d;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  final file = await _imagePicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }
  d.log('No image selected');
  return null;
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}
