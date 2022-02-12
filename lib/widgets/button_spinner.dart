import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/colors.dart';

class ButtonSpinner extends StatelessWidget {
  const ButtonSpinner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
          height: 17,
          width: 17,
          child: CircularProgressIndicator(
            color: primaryColor,
          )),
    );
  }
}
