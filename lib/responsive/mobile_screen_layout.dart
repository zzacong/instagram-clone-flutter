import 'package:flutter/material.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(child: Container(), flex: 1),
          const Center(child: Text("mobile screen layout")),
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
