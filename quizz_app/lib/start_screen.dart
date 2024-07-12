import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  /* constructor */
  const StartScreen(this.switchScreenFunction, {super.key});

  final void Function() switchScreenFunction;

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
          Text(
            'Quizz App for Flutter training',
            style: GoogleFonts.lato(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: switchScreenFunction,
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
