class QuestionModel {
  const QuestionModel(this.questionText, this.options);
  final String questionText;
  final List<String> options;

  List<String> getShuffledAnswers() {
    final shuffledList = List.of(options);
    shuffledList
        .shuffle(); /* Shuffle modifies the order of the original list and void is returned */
    return shuffledList;
  }
}
