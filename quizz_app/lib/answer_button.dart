import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({
    super.key,
    required this.buttonLabel,
    required this.onButtonClick,
  });

  final String buttonLabel;
  final void Function() onButtonClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: ElevatedButton(
        onPressed: onButtonClick,
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(199, 29, 29, 29)),
        child: Text(
          buttonLabel,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
