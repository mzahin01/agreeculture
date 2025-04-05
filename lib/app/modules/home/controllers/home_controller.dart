import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/ques_strings.dart';

class QuestionDetails {
  final String text;
  int answers;

  QuestionDetails({required this.text, required this.answers});
}

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool toUpdate = false.obs;
  RxList<QuestionDetails>? questions = <QuestionDetails>[].obs;
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
            .toList()
            .obs;
  }

  // Answers List (default value -1 means no selection)
  RxList<int> selectedAnswers = List<int>.filled(2, -1).obs;

  // Function to update answers
  void selectAnswer(int questionIndex, int value) {
    selectedAnswers[questionIndex] = value;
  }

  void vote(int index, int i) {
    if (questions?[index].answers == i) {
      questions?[index].answers = -1;
    } else {
      questions?[index].answers = i;
    }
    toUpdate.value = !toUpdate.value;
  }

  bool checkAllVotes() {
    for (int i = 0; i < questions!.length; i++) {
      if (questions![i].answers == -1) {
        // Get.snackbar("Error", "Please select an answer for all questions");
        // in bangla
        Get.snackbar(
          "ত্রুটি",
          "অনুগ্রহ করে সকল প্রশ্নের জন্য একটি উত্তর নির্বাচন করুন",
          colorText: Colors.white,
          backgroundColor: Colors.red.withAlpha(200),
        );
        return false;
      }
    }
    return true;
  }

  String getVoteResult() {
    String result = '';
    for (int i = 0; i < questions!.length; i++) {
      if (questions![i].answers == -1) {
        result += '0';
      } else {
        result += questions![i].answers.toString();
      }
    }
    return result;
  }
}
