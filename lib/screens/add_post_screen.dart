import 'dart:typed_data';
import 'dart:developer' as d;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/providers/user_provider.dart';
import 'package:instagram_flutter/resources/firestore_methods.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;
  // bool _isLoading = true;
  Uint8List? _image;
  String? _imageType;

  void _onSelectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              title: const Text('Create a post'),
              children: [
                SimpleDialogOption(
                  padding: const EdgeInsets.all(20),
                  child: const Text('Take a photo'),
                  onPressed: () async {
                    Navigator.pop(context);
                    List? l = await pickImage(ImageSource.camera);
                    if (l != null) {
                      Uint8List image = l[0];
                      String imageType = l[1];
                      setState(() {
                        _image = image;
                        _imageType = imageType;
                      });
                    }
                  },
                ),
                SimpleDialogOption(
                  padding: const EdgeInsets.all(20),
                  child: const Text('Choose from gallery'),
                  onPressed: () async {
                    Navigator.pop(context);
                    List? l = await pickImage(ImageSource.gallery);
                    if (l != null) {
                      Uint8List image = l[0];
                      String imageType = l[1];
                      setState(() {
                        _image = image;
                        _imageType = imageType;
                      });
                    }
                  },
                ),
                SimpleDialogOption(
                  padding: const EdgeInsets.all(20),
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ));
  }

  void _onPostImage(String uid, String username, String profileImage) async {
    try {
      setState(() => _isLoading = true);
      String res = await FirestoreMethods.uploadPost(
        description: _descriptionController.text,
        file: _image!,
        fileType: _imageType!,
        uid: uid,
        username: username,
        profileImage: profileImage,
      );
      d.log(res);
      showSnackBar('Posted!', context);
      clearImage();
    } catch (error) {
      showSnackBar(error.toString(), context);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void clearImage() {
    setState(() {
      _image = null;
      _imageType = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return _image == null
        ? Center(
            child: IconButton(
              onPressed: () => _onSelectImage(context),
              icon: const Icon(Icons.upload),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                onPressed: clearImage,
                icon: const Icon(Icons.arrow_back),
              ),
              title: const Text('Post to'),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: () =>
                      _onPostImage(user!.uid, user.username, user.photoUrl),
                  child: const Text(
                    'Post',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
            body: Column(
              children: [
                _isLoading
                    ? const LinearProgressIndicator()
                    : const Padding(padding: EdgeInsets.only(top: 0)),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user!.photoUrl),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            hintText: 'Write a caption...',
                            border: InputBorder.none,
                          ),
                          maxLines: 8,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: AspectRatio(
                          aspectRatio: 487 / 451,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: MemoryImage(_image!),
                                fit: BoxFit.fill,
                                alignment: FractionalOffset.topCenter,
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
                const Divider(),
              ],
            ),
          );
  }
}
