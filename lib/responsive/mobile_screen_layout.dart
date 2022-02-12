import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/user.dart' as m;
import 'package:instagram_flutter/providers/user_provider.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  @override
  Widget build(BuildContext context) {
    m.User user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: Column(
        children: [
          Flexible(child: Container(), flex: 1),
          Center(child: Text(user.username)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => AuthMethods.signOut(),
            child: const Text('Sign out'),
          ),
          Flexible(child: Container(), flex: 1),
        ],
      ),
    );
  }
}
