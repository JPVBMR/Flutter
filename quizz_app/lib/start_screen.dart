import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  /* constructor */
  const StartScreen({super.key});

  @override
  Widget build(context) {
    return Center(
      child: Column(
        /* Vertical Alignment */
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/quiz-logo.png',
            width: 200,
            color: Color.fromARGB(199, 255, 255, 255), //Fake opacity of images
          ),
          const SizedBox(height: 60),
          const Text(
            'Quizz App for Flutter training',
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.arrow_forward_sharp),
            label: const Text('Start Quiz'),
          ),
        ],
      ),
    );
  }
}
