import 'dart:math';
import 'package:agreeculture/app/modules/result_show/widget/radar_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/widget/animated/crossfade_wrapper_container.dart';
import '../../../shared/widget/responseive_view/response_view.dart';
import '../controllers/result_show_controller.dart';
import '../widget/result_summury.dart';

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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // Result Summary Card
            ResultSummuryWidget(controller: controller),

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
}
