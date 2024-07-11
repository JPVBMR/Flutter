import 'package:flutter/material.dart';

class JBStyledText extends StatelessWidget {
  const JBStyledText(this.textToDisplay, {super.key});

  /* Property/Class Variables */
  final String textToDisplay;

  @override
  Widget build(context) {
    return Text(
      textToDisplay,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 28,
      ),
    );
  }
}
