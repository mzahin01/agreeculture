import 'package:get/get.dart';

import '../controllers/result_show_controller.dart';

class ResultShowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResultShowController>(
      () => ResultShowController(),
    );
  }
}
