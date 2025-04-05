import 'package:get/get.dart';

class ResultShowController extends GetxController {
  int ncpMatches = 0;
  int bnpMatches = 0;
  String bestMatch = '';
  int bestMatchPercent = 0;
  RxBool isLoading = false.obs;
  RxString questions = ''.obs;
  String ncpResult = '44443444444';
  String bnpResult = '10000000001';
  @override
  void onInit() {
    questions.value = Get.parameters['q'] ?? '';
    // Calculate match percentages
    ncpMatches = calculateMatchPercentage(questions.value, ncpResult);
    bnpMatches = calculateMatchPercentage(questions.value, bnpResult);

    // Determine the best match
    bestMatch = ncpMatches >= bnpMatches ? 'NCP' : 'BNP';
    bestMatchPercent = ncpMatches >= bnpMatches ? ncpMatches : bnpMatches;
    super.onInit();
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

  shareInfo() {
    // Implement your share functionality here
    // For example, you can use the Share package to share the result
    // Share.share('Your result: $bestMatch with $bestMatchPercent% match');
  }
}
