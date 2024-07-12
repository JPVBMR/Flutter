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

## Key Concepts

### Flutter Basics

- **Main Entry Point**
  - The `main` function in the main Dart file is the entry point, executed automatically by Dart when the app starts.
  - Use `runApp` to pass your widget tree to the app.

### Widgets

- **Stateful and Stateless Widgets**
  - Built various widgets and passed data between them.
  - Learned to accept and use functions as input values in widgets.

### State Management

- **Conditional Content**
  - Use the `if` keyword to set variable values based on state, allowing for different UI states.
  - **Ternary Expressions**: A concise way of setting content conditionally.

### Dart Programming

- **Passing Functions**
  - Functions can be passed as values, enabling dynamic behavior in widgets.

- **For Loops**
  - Execute code repeatedly until a condition is met.
  - Used to process user answers and create summary data.

- **Maps**
  - Combine key-value pairs into one object.
  - Understand the importance of type casting when using maps.

### List Operations

- **List Methods**
  - **shuffle**: Change the order of list items.
  - **add**: Add new entries to a list.
  - **where**: Filter a list based on a condition.
  - **map**: Generate a new list of transformed items.
  - **Spread Operator (`...`)**: Add list elements as standalone items to a surrounding list.

### Widgets and Styling

- **SingleChildScrollView**
  - Make child widgets scrollable while restricting size.

- **Styling Options**
  - Configurations like the **shape** option for buttons to add rounded borders.

### Custom Classes

- **Standard Classes**
  - Use the `class` keyword to build standard classes for non-widget objects.
  - Example: A class for question text and possible answers with a method for shuffling answers.




