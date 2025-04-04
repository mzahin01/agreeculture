import 'package:get/get.dart';

class ResultShowController extends GetxController {
  RxBool isLoading = false.obs;
  RxString questions = ''.obs;
  String ncpResult = '44443444444';
  String bnpResult = '10000000001';
  @override
  void onInit() {
    questions.value = Get.parameters['q'] ?? '';
    super.onInit();
  }
}
