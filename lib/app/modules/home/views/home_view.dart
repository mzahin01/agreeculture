import 'package:agreeculture/app/modules/home/widget/title.dart';
import 'package:agreeculture/app/routes/app_pages.dart';
import 'package:agreeculture/app/shared/widget/button/bar_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/widget/animated/crossfade_wrapper_container.dart';
import '../../../shared/widget/responseive_view/response_view.dart';
import '../controllers/home_controller.dart';
import '../widget/single_q.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        return SingleChildScrollView(
          child: CrossfadeWrapperContainer(
            visible: !controller.isLoading.value,
            loaderHeight: Get.height,
            //Pass respective controller to the widget
            child: ResponsiveWidget<HomeController>(
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
      child: Column(
        children: [
          const SizedBox(height: 20),
          TopTitleWidget(),
          DetailsWidget(),
          for (int i = 0; i < (controller.questions?.length ?? 0); i++)
            Column(
              children: [
                SingleQuestionWidget(controller: controller, index: i),
                const SizedBox(height: 20),
              ],
            ),
          // SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BarButton(
              height: 55,
              title: 'Analyze Your Opinion',
              onPressed: () {
                Get.toNamed(
                  Routes.RESULT_SHOW,
                  arguments: {'questions': controller.questions},
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
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
