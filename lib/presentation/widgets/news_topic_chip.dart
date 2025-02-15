import 'package:flutter/material.dart';

class NewsTopicChip extends StatelessWidget {
  const NewsTopicChip(
      {super.key,
      required this.text,
      required this.onPressed,
      this.activeBackgroundColor,
      this.activeForegroundColor});

  final String text;
  final Function() onPressed;
  final Color? activeBackgroundColor;
  final Color? activeForegroundColor;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(text),
      onPressed: onPressed,
      backgroundColor: activeBackgroundColor,
      labelStyle: TextStyle(color: activeForegroundColor),
    );
  }
}
