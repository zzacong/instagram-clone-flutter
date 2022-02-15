import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final Function()? onPressed;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final String text;

  const FollowButton(
      {Key? key,
      this.onPressed,
      required this.backgroundColor,
      required this.borderColor,
      required this.text,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: TextButton(
        onPressed: onPressed,
        child: Container(
          height: 27,
          width: 250,
          decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(5)),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
