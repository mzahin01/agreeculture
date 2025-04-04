import 'package:get/get.dart';

import '../controllers/credit_and_about_us_controller.dart';

class CreditAndAboutUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreditAndAboutUsController>(
      () => CreditAndAboutUsController(),
    );
  }
}
