import 'dart:math';
import 'package:flutter/material.dart';
import '../controllers/result_show_controller.dart';

class ResultSummuryWidget extends StatelessWidget {
  const ResultSummuryWidget({super.key, required this.controller});

  final ResultShowController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: min(double.maxFinite, 600),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'আপনার মতামত বিশ্লেষণ',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Text(
            'আপনার মতামত ${controller.bestMatch} এর সাথে ${controller.bestMatch}Percent% মিল রয়েছে',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          // Comparison bars
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'NCP',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        controller.bestMatch == 'NCP'
                            ? Colors.blue
                            : Colors.black,
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Stack(
                  children: [
                    Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      height: 20,
                      width:
                          (controller.ncpMatches / 100) *
                          300, // Adjust width based on screen size
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text('${controller.ncpMatches}%'),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'BNP',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        controller.bestMatch == 'BNP'
                            ? Colors.red
                            : Colors.black,
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Stack(
                  children: [
                    Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      height: 20,
                      width:
                          (controller.bnpMatches / 100) *
                          300, // Adjust width based on screen size
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text('${controller.bnpMatches}%'),
            ],
          ),
        ],
      ),
    );
  }
}
