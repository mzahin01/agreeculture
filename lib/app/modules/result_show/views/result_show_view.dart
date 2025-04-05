import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/widget/animated/crossfade_wrapper_container.dart';
import '../../../shared/widget/responseive_view/response_view.dart';
import '../controllers/result_show_controller.dart';
import '../widget/result_summury.dart';
import '../widget/share_button.dart';
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
        child: RepaintBoundary(
          key: controller.widgetKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              ResultSummuryWidget(controller: controller),
              const SizedBox(height: 30),
              MyOpinion(controller: controller),
              const SizedBox(height: 30),
              OtherOpinions(controller: controller),
              const SizedBox(height: 50),
              ShareButtonWidget(controller: controller),
            ],
          ),
        ),
      ),
    );
  }
}
