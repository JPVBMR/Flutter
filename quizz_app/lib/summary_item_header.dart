import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SummaryItemHeader extends StatelessWidget {
  const SummaryItemHeader({
    super.key,
    required this.isCorrectAnswer,
    required this.questionIndex,
  });

  final bool isCorrectAnswer;
  final int questionIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: isCorrectAnswer
            ? const Color.fromARGB(255, 150, 198, 241)
            : Color.fromARGB(255, 219, 42, 86),
      ),
      child: Text(
        questionIndex.toString(),
        style: GoogleFonts.lato(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
