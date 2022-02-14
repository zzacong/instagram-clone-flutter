import 'dart:typed_data';
import 'dart:developer' as d;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';
import 'package:instagram_flutter/responsive/mobile_screen_layout.dart';
import 'package:instagram_flutter/responsive/responsive_layout_screen.dart';
import 'package:instagram_flutter/responsive/web_screen_layout.dart';
import 'package:instagram_flutter/screens/login_screen.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/utils.dart';
import 'package:instagram_flutter/widgets/button_spinner.dart';
import 'package:instagram_flutter/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  String? _imageType;
  bool _isLoading = false;

  void selectImage() async {
    List? l = await pickImage(ImageSource.gallery);
    if (l != null) {
      Uint8List image = l[0];
      String imageType = l[1];
      setState(() {
        _image = image;
        _imageType = imageType;
      });
    }
  }

  void onSignUp() async {
    setState(() => _isLoading = true);
    final res = await AuthMethods.signUp(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
      fileType: _imageType!,
    );
    d.log('sign up: $res');

    setState(() => _isLoading = false);
    if (res == 'success') {
      setState(() {
        _image = null;
        _imageType = null;
      });
      _emailController.clear();
      _passwordController.clear();
      _bioController.clear();
      _usernameController.clear();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      // signup failed, display error
      showSnackBar(res, context);
    }
  }

  void onLogin() {
    // navigate to sign up screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(child: Container(), flex: 2),

              // svg image
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(height: 64),

              // circular avatar widget
              Stack(
                children: <Widget>[
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                            'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                          ),
                        ),
                  Positioned(
                    bottom: -10,
                    right: 0,
                    child: IconButton(
                      onPressed: () => selectImage(),
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 36),

              // text field input for username
              TextFieldInput(
                hintText: 'Enter your username',
                textInputType: TextInputType.text,
                controller: _usernameController,
              ),
              const SizedBox(height: 12),

              // text field input for email
              TextFieldInput(
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              const SizedBox(height: 12),

              // text field input for password
              TextFieldInput(
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                controller: _passwordController,
                isPasswd: true,
              ),
              const SizedBox(height: 12),

              // text field input for bio
              TextFieldInput(
                hintText: 'Enter your bio',
                textInputType: TextInputType.text,
                controller: _bioController,
              ),
              const SizedBox(height: 12),

              // button login
              InkWell(
                onTap: onSignUp,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: blueColor,
                  ),
                  child: _isLoading
                      ? const ButtonSpinner()
                      : const Text('Sign up'),
                ),
              ),
              Flexible(child: Container(), flex: 2),

              // transition to sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text("Already have an account?"),
                  ),
                  GestureDetector(
                    onTap: onLogin,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: const Text(
                        "Log in.",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
