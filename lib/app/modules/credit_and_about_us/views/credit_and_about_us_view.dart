import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../shared/widget/animated/crossfade_wrapper_container.dart';
import '../../../shared/widget/responseive_view/response_view.dart';
import '../controllers/credit_and_about_us_controller.dart';

class CreditAndAboutUsView extends GetView<CreditAndAboutUsController> {
  const CreditAndAboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return SingleChildScrollView(
          child: CrossfadeWrapperContainer(
            visible: !controller.isLoading.value,
            loaderHeight: Get.height,
            //Pass respective controller to the widget
            child: ResponsiveWidget<CreditAndAboutUsController>(
              pc: buildDesktopView(),
              tab: buildTabletView(),
              mobile: buildMobileView(),
            ),
          ),
        );
      }),
    );
  }

  // Mobile layout
  Widget buildMobileView() {
    return Center(child: const Text('Mobile View'));
  }

  // Tablet layout
  Widget buildTabletView() {
    return Center(child: const Text('Tablet View'));
  }

  // Desktop layout
  Widget buildDesktopView() {
    return Center(child: const Text('Desktop View'));
  }
}
