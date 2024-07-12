import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizz_app/mock_data/questions.dart';
import 'package:quizz_app/summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen(
      {super.key,
      required this.lstSelectedAnswers,
      required this.onRestartClick});
  final List<String> lstSelectedAnswers;
  final Function() onRestartClick;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < lstSelectedAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questionsList[i].questionText,
        'correct_answer': questionsList[i].options[0],
        'selected_answer': lstSelectedAnswers[i]
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    /* Get Correct Answers */
    final summaryData = getSummaryData();
    final numTotalQuestions = questionsList.length;
    final numCorrectQuestions = summaryData.where((item) {
      return item['correct_answer'] == item['selected_answer'];
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$numCorrectQuestions / $numTotalQuestions Answered Correctly',
              style: GoogleFonts.lato(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 20),
            QuestionsSummary(
              summaryData: summaryData,
            ),
            OutlinedButton.icon(
              onPressed: onRestartClick,
              icon: const Icon(
                Icons.restart_alt_rounded,
                color: Colors.white,
              ),
              label: Text(
                'Restart Quiz',
                style: GoogleFonts.lato(color: Colors.white, fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
