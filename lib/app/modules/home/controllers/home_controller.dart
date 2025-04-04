import 'package:get/get.dart';

import '../data/ques_strings.dart';

class QuestionDetails {
  final String text;
  final int answers;

  QuestionDetails({required this.text, required this.answers});
}

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  List<QuestionDetails> questions = [];
  @override
  void onInit() {
    super.onInit();
    loadQuestions();
  }

  void loadQuestions() {
    // Import the reformProposals list from ques_strings.dart
    questions =
        reformProposals
            .map((proposal) => QuestionDetails(text: proposal, answers: -1))
            .toList();
  }

  // Answers List (default value -1 means no selection)
  RxList<int> selectedAnswers = List<int>.filled(2, -1).obs;

  // Function to update answers
  void selectAnswer(int questionIndex, int value) {
    selectedAnswers[questionIndex] = value;
  }

  void vote(int index, int i) {}
}
