import 'dart:developer' as d;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

Future<List?> pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  final file = await _imagePicker.pickImage(source: source);
  if (file != null) {
    var type = path.extension(file.name).substring(1);
    return [await file.readAsBytes(), type];
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
