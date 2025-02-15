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
    return InkWell(
      onTap: onPressed,
      splashColor: Colors.transparent,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: activeBackgroundColor,
            borderRadius: BorderRadius.circular(24)),
        child: Text(text, style: TextStyle(color: activeForegroundColor)),
      ),
    );
  }
}
