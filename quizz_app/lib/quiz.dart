import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quizz_app/mock_data/questions.dart';
import 'package:quizz_app/questions_screen.dart';
import 'package:quizz_app/results_screen.dart';
import 'package:quizz_app/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  Widget? activeScreen;
  List<String> userSelectedAnswers = [];

  /* Initialize the State */
  @override
  void initState() {
    activeScreen = StartScreen(switchScreen);
    super.initState();
  }

  void switchScreen() {
    /* Forces the build to re-execute */
    setState(() {
      activeScreen =
          QuestionsScreen(addSelectedAnswer: addSelectedAnswerToGlobalList);
    });
  }

  void restartQuizz() {
    setState(() {
      userSelectedAnswers = [];
      activeScreen = StartScreen(switchScreen);
    });
  }

  void addSelectedAnswerToGlobalList(String selectedAnswer) {
    userSelectedAnswers.add(selectedAnswer);

    /* End of questions reached --> Result Screen */
    if (userSelectedAnswers.length == questionsList.length) {
      setState(() {
        activeScreen = ResultsScreen(
          lstSelectedAnswers: userSelectedAnswers,
          onRestartClick: restartQuizz,
        );
        userSelectedAnswers = []; //Reset selected answers
      });
    }
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 1, 41, 114),
                Color.fromARGB(255, 4, 121, 255),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: activeScreen,
        ),
      ),
    );
  }
}
