import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/user.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User get user => _user!;

  Future<void> refreshUser() async {
    _user = await AuthMethods.getUserDetails();
    notifyListeners();
  }
}
