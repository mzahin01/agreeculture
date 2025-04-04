import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../controllers/home_controller.dart';

class SingleQuestionWidget extends StatelessWidget {
  const SingleQuestionWidget({
    super.key,
    required this.controller,
    required this.index,
  });

  final HomeController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: min(double.maxFinite, 600),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(50),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Question(ques: controller.questions?[index].text ?? ''),
          const SizedBox(height: 20),
          Options(controller: controller, index: index),
          const SizedBox(height: 20),
          Indicator(),
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.arrow_back, color: Colors.red, size: 25),
          Column(
            children: [
              Text(
                'সহমত না',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Container(
                width: 35,
                height: 3,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(1.5),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'মেহ !',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Container(
                width: 25,
                height: 3,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(1.5),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'সহমত ভাই',
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Container(
                width: 45,
                height: 3,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(1.5),
                ),
              ),
            ],
          ),
          Icon(Icons.arrow_forward, color: Colors.green, size: 25),
        ],
      ),
    );
  }
}

class Options extends StatelessWidget {
  const Options({super.key, required this.controller, required this.index});

  final HomeController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < 5; i++)
            GestureDetector(
              onTap: () {
                controller.vote(index, i);
              },
              child: SizedBox(
                width:
                    (i == 0 || i == 4)
                        ? 58.0
                        : (i == 1 || i == 3)
                        ? 50.0
                        : 45.0,
                height:
                    (i == 0 || i == 4)
                        ? 58.0
                        : (i == 1 || i == 3)
                        ? 50.0
                        : 45.0,
                // color: Colors.black,
                child: Stack(
                  children: [
                    Container(
                      width:
                          (i == 0 || i == 4)
                              ? 58.0
                              : (i == 1 || i == 3)
                              ? 50.0
                              : 45.0,
                      height:
                          (i == 0 || i == 4)
                              ? 58.0
                              : (i == 1 || i == 3)
                              ? 50.0
                              : 45.0,
                      decoration: BoxDecoration(
                        color:
                            [
                              Colors.red,
                              Colors.orange,
                              Colors.grey,
                              Colors.lightGreen,
                              Colors.green,
                            ][i],
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    Center(
                      child: Container(
                        width:
                            (i == 0 || i == 4)
                                ? 48.0
                                : (i == 1 || i == 3)
                                ? 40.0
                                : 35.0,
                        height:
                            (i == 0 || i == 4)
                                ? 48.0
                                : (i == 1 || i == 3)
                                ? 40.0
                                : 35.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: Text(
                            ['জঘন্য', 'পচা', 'মেহ!', 'অকে', 'সেরা'][i],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (controller.questions?[index].answers == i)
                      Container(
                        width:
                            (i == 0 || i == 4)
                                ? 58.0
                                : (i == 1 || i == 3)
                                ? 50.0
                                : 45.0,
                        height:
                            (i == 0 || i == 4)
                                ? 58.0
                                : (i == 1 || i == 3)
                                ? 50.0
                                : 45.0,
                        decoration: BoxDecoration(
                          color:
                              [
                                Colors.red,
                                Colors.orange,
                                Colors.grey,
                                Colors.lightGreen,
                                Colors.green,
                              ][i],
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size:
                                (i == 0 || i == 4)
                                    ? 40.0
                                    : (i == 1 || i == 3)
                                    ? 35.0
                                    : 30.0,
                          ),
                        ),
                      ),
                    if (controller.toUpdate.value || !controller.toUpdate.value)
                      SizedBox(),
                  ],
                ),
              ),
            ),
        ],
      );
    });
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
            style: const TextStyle(
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
            style: const TextStyle(
              color: Colors.blueAccent,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }
    }

    return RichText(
      text: TextSpan(children: textSpans),
      textAlign: TextAlign.center,
      softWrap: true,
      overflow: TextOverflow.visible,
      maxLines: null,
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: 'সহমত ভাই',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          children: <TextSpan>[
            TextSpan(
              text: '  by DespicableApp',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
