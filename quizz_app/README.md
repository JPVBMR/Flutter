# Quizz Application - Multi Screens 

![image](https://github.com/user-attachments/assets/2ec23ce1-372a-4cc5-b3ed-b98163de6dc0)

## How to Run

1. Ensure you have Flutter installed. If not, follow the instructions [here](https://flutter.dev/docs/get-started/install).
2. Clone this repository.
3. Run `flutter create .` to create the flutter app configurations.
4. Run `flutter pub get` to install dependencies.
5. Use `flutter run` to start the application on an emulator or physical device.

## File Structure

- [**main.dart**](./lib/main.dart): The entry point of the application, which initializes and runs the `Quiz` widget.

- [**quiz.dart**](./lib/quiz.dart): The `Quiz` widget manages the state of the application and controls the navigation between different screens.

- [**start_screen.dart**](./lib/start_screen.dart): The `StartScreen` widget is the initial screen where users can start the quiz.

- [**questions_screen.dart**](./lib/questions_screen.dart): The `QuestionsScreen` widget displays the current question and possible answers.

- [**results_screen.dart**](./lib/results_screen.dart): The `ResultsScreen` widget shows the quiz results and provides a summary.

- [**summary.dart**](./lib/summary.dart): The `QuestionsSummary` widget displays a scrollable summary of the quiz results.

- [**summary_item.dart**](./lib/summary_item.dart): The `SummaryItem` widget is used to display each individual question's details in the summary.

- [**models/question_model.dart**](./models/question_model.dart): The `QuestionModel` class defines the structure of a quiz question and provides functionality to shuffle answer options.

## Dependencies

- [google_fonts](https://pub.dev/packages/google_fonts)



