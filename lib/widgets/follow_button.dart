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
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 4),
        alignment: Alignment.center,
        primary: backgroundColor,
        onPrimary: textColor,
        side: BorderSide(color: borderColor),
        minimumSize: const Size(double.infinity, 26),
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
        elevation: 0,
      ),
      child: Text(text),
    );
  }
}
