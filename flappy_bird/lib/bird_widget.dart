import 'package:flutter/material.dart';

class Bird extends StatelessWidget {
  final double birdY;

  const Bird({super.key, required this.birdY});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, birdY),
      child: Image.asset(
        'assets/bird.png',
        width: 120,
        height: 120,
      ),
    );
  }
}
