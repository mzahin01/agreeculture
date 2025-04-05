import 'dart:math';
import 'package:agreeculture/app/modules/result_show/widget/radar_chart.dart';
import 'package:flutter/material.dart';
import '../controllers/result_show_controller.dart';

class OtherOpinions extends StatelessWidget {
  const OtherOpinions({super.key, required this.controller});

  final ResultShowController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: min(double.maxFinite, 600),
      child: Column(
        children: [
          const Text(
            'রাজনৈতিক দলের অবস্থান',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: RadarChartWidget(
                  dataString: controller.ncpResult,
                  title: 'NCP',
                  graphColor: Colors.blue,
                ),
              ),
              Expanded(
                child: RadarChartWidget(
                  dataString: controller.bnpResult,
                  title: 'BNP',
                  graphColor: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MyOpinion extends StatelessWidget {
  const MyOpinion({super.key, required this.controller});

  final ResultShowController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: min(double.maxFinite, 600),
      child: RadarChartWidget(
        dataString: controller.questions.value,
        title: 'আপনার মতামত',
        graphColor: Colors.purple,
      ),
    );
  }
}
