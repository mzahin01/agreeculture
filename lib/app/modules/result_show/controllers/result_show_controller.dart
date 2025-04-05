import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

class ResultShowController extends GetxController {
  int ncpMatches = 0;
  int bnpMatches = 0;
  String bestMatch = '';
  int bestMatchPercent = 0;
  RxBool isLoading = false.obs;
  RxString questions = ''.obs;
  String ncpResult = '44443444444';
  String bnpResult = '10000000001';
  // Key to identify the widget to capture
  final GlobalKey widgetKey = GlobalKey();
  // State to track if capturing is in progress
  bool isCapturing = false;
  // State to store the captured image data
  Uint8List? capturedImage;

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

  Future<void> shareInfo() async {
    // Set state to show loading indicator
    isCapturing = true;

    try {
      // Find the RenderObject using the GlobalKey
      RenderRepaintBoundary boundary =
          widgetKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      // Capture the widget's rendering as an image
      // pixelRatio increases resolution (e.g., 3.0 for higher quality)
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      // Convert the ui.Image to byte data in PNG format
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      if (byteData != null) {
        // Convert ByteData to Uint8List
        final bytes = byteData.buffer.asUint8List();

        // Update state with the captured image bytes
        capturedImage = bytes;

        debugPrint('Image captured successfully! ${bytes.length} bytes');
      } else {
        debugPrint('Error: Could not get byte data from image.');
        capturedImage = null;
      }
    } catch (e) {
      debugPrint('Error capturing image: $e');
      capturedImage = null;
    } finally {
      // Ensure the loading state is turned off
      isCapturing = false;
    }
  }

  // --- End of Method to Capture Image ---
}
