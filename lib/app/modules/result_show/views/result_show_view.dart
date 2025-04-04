import 'dart:math';
import 'package:agreeculture/app/modules/result_show/widget/radar_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/widget/animated/crossfade_wrapper_container.dart';
import '../../../shared/widget/responseive_view/response_view.dart';
import '../controllers/result_show_controller.dart';

class ResultShowView extends GetView<ResultShowController> {
  const ResultShowView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ফলাফল বিশ্লেষণ'), centerTitle: true),
      body: Obx(() {
        return SingleChildScrollView(
          child: CrossfadeWrapperContainer(
            visible: !controller.isLoading.value,
            loaderHeight: Get.height,
            child: ResponsiveWidget<ResultShowController>(
              pc: buildMobileView(),
              tab: buildMobileView(),
              mobile: buildMobileView(),
            ),
          ),
        );
      }),
    );
  }

  // Mobile layout
  Widget buildMobileView() {
    // Calculate match percentages
    int ncpMatches = calculateMatchPercentage(
      controller.questions.value,
      controller.ncpResult,
    );
    int bnpMatches = calculateMatchPercentage(
      controller.questions.value,
      controller.bnpResult,
    );

    // Determine the best match
    String bestMatch = ncpMatches >= bnpMatches ? 'NCP' : 'BNP';
    int bestMatchPercent = ncpMatches >= bnpMatches ? ncpMatches : bnpMatches;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // Result Summary Card
            Container(
              width: min(double.maxFinite, 600),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
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
                    'আপনার মতামত $bestMatch এর সাথে $bestMatchPercent% মিল রয়েছে',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
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
                                bestMatch == 'NCP' ? Colors.blue : Colors.black,
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
                                  (ncpMatches / 100) *
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
                      Text('$ncpMatches%'),
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
                                bestMatch == 'BNP' ? Colors.red : Colors.black,
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
                                  (bnpMatches / 100) *
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
                      Text('$bnpMatches%'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // User's result chart
            SizedBox(
              width: min(double.maxFinite, 600),
              child: RadarChartWidget(
                dataString: controller.questions.value,
                title: 'আপনার মতামত',
                graphColor: Colors.purple,
              ),
            ),

            const SizedBox(height: 30),

            // Political party charts side by side
            SizedBox(
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
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Calculate match percentage between two answer strings
  int calculateMatchPercentage(String userAnswers, String partyAnswers) {
    if (userAnswers.isEmpty ||
        partyAnswers.isEmpty ||
        userAnswers.length != partyAnswers.length) {
      return 0;
    }

    int matches = 0;
    int total = userAnswers.length;

    for (int i = 0; i < total; i++) {
      int userVal = int.tryParse(userAnswers[i]) ?? 0;
      int partyVal = int.tryParse(partyAnswers[i]) ?? 0;

      // Calculate similarity (0 = different, 1 = identical)
      double similarity = 1 - (userVal - partyVal).abs() / 4.0;
      matches += (similarity * 100).round();
    }

    return (matches / total).round();
  }
}
