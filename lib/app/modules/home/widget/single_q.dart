import 'package:flutter/material.dart';
import '../controllers/home_controller.dart';

class SingleQuestionWidget extends StatelessWidget {
  const SingleQuestionWidget({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Question(ques: controller.reformProposals[0]),
    );
  }
}

class Question extends StatelessWidget {
  const Question({super.key, required this.ques});

  final String ques;
  List<String> get quesList => ques.split('*');

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textSpans = [];
    for (int i = 0; i < quesList.length; i++) {
      if (i % 2 == 0) {
        textSpans.add(
          TextSpan(
            text: quesList[i],
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        );
      } else {
        textSpans.add(
          TextSpan(
            text: quesList[i],
            style: TextStyle(
              color: Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }
    }

    return RichText(
      text: TextSpan(children: textSpans),
      softWrap: true,
      overflow: TextOverflow.visible,
      maxLines: null,
    );
  }
}
