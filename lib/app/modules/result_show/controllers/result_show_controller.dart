import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';

class ResultShowController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<QuestionDetails>? questions = <QuestionDetails>[].obs;
  @override
  void onInit() {
    questions = Get.arguments['questions'] ?? <QuestionDetails>[].obs;
    super.onInit();
  }
}
