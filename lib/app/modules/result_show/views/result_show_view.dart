import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/widget/animated/crossfade_wrapper_container.dart';
import '../../../shared/widget/responseive_view/response_view.dart';
import '../controllers/result_show_controller.dart';
import '../widget/result_summury.dart';
import '../widget/wrappers.dart';

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
            MyOpinion(controller: controller),
            const SizedBox(height: 30),
            // Political party charts side by side
            OtherOpinions(controller: controller),
            const SizedBox(height: 50),
            Container(
              width: min(double.maxFinite, 600),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextButton(
                onPressed: () {
                  // Navigate to the home page
                  controller.shareInfo();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.share, color: Colors.white, size: 30),
                    const SizedBox(width: 20),
                    const Text(
                      'Share Result',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
