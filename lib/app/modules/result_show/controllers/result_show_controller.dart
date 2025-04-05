import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'dart:io'; // For File (non-web)
import 'package:flutter/foundation.dart' show kIsWeb; // To check platform
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart'; // For sharing and XFile
// ignore: deprecated_member_use, avoid_web_libraries_in_flutter
import 'dart:html' as html; // For Blob (web)
import 'package:path_provider/path_provider.dart'; // For temp directory (non-web)
import 'dart:typed_data'; // For Uint8List

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
      // Wait for the next frame to ensure rendering is complete
      await Future.delayed(Duration.zero);

      // Find the RenderObject using the GlobalKey
      RenderRepaintBoundary boundary =
          widgetKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      // Ensure the boundary has been laid out
      if (boundary.debugNeedsPaint) {
        await Future.delayed(const Duration(milliseconds: 20));
      }

      // Capture the widget's rendering as an image
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
        await shareImage();
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

  Future<void> shareImage() async {
    // Check if an image has been captured
    if (capturedImage == null) {
      debugPrint('No image to share');
      // Optional: Show a snackbar or message to the user
      Get.snackbar(
        'No Image Captured',
        'Please capture an image first!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    try {
      // Create an XFile from the image bytes
      // This is used by share_plus regardless of platform
      final xFile = XFile.fromData(
        capturedImage!,
        name: 'parameters.png', // Suggested filename
        mimeType: 'image/png', // Set the correct MIME type
      );

      // Platform specific sharing logic
      if (kIsWeb) {
        // Web platform: Use share_plus directly with XFile
        // Note: Web Share API support varies across browsers.

        // The Blob/Url creation was in the original code, but shareXFiles
        // can often handle the Uint8List directly via XFile.fromData
        // If direct sharing fails, the Blob method might be a fallback,
        // but usually isn't needed with modern share_plus.

        final shareResult = await Share.shareXFiles(
          [xFile],
          text: 'Check out these parameters I captured!',
          subject: 'Shared Parameters', // Subject often used in email sharing
        );

        debugPrint('Web Share result: ${shareResult.status}');

        // Check if sharing was potentially dismissed or unavailable
        if (shareResult.status == ShareResultStatus.dismissed) {
          debugPrint('Share dialog was dismissed.');
        } else if (shareResult.status == ShareResultStatus.unavailable) {
          debugPrint('Sharing is unavailable. Falling back to download.');
          downloadImage(); // Fallback if Web Share API isn't supported/successful
        }
      } else {
        // Non-web platforms (Mobile, Desktop)
        // Save to a temporary file first, as shareXFiles needs a path
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/parameters.png');
        await file.writeAsBytes(capturedImage!);

        // Share the temporary file using its path
        final shareResult = await Share.shareXFiles(
          [XFile(file.path)], // Pass the file path inside XFile
          text: 'Check out these parameters I captured!',
          subject: 'Shared Parameters',
        );
        debugPrint('Non-Web Share result: ${shareResult.status}');
        // Optionally delete the temp file after sharing attempt
        // await file.delete();
      }
    } catch (e) {
      debugPrint('Error sharing image: $e');
      // Fallback specifically for Web if the primary share method failed
      if (kIsWeb) {
        debugPrint('Sharing failed, attempting fallback download.');
        downloadImage(); // Fallback to download on error for web
      } else {
        // Handle non-web errors (e.g., show a message)
        Get.snackbar(
          'Error Sharing Image',
          'Could not share image. Error: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    }
  }

  void downloadImage() {
    // Check if an image has been captured
    if (capturedImage == null) {
      debugPrint('No image to download');
      Get.snackbar(
        'No Image Captured',
        'Please capture an image first!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    // Ensure this runs only on the web
    if (kIsWeb) {
      try {
        // 1. Encode image bytes to Base64
        final base64 = base64Encode(capturedImage!);

        // 2. Create a data URL (RFC 2397)
        final dataUrl = 'data:image/png;base64,$base64';

        // 3. Create an invisible HTML anchor element (`<a>`)
        final anchor = html.AnchorElement(href: dataUrl)
          // 4. Set the 'download' attribute with a filename
          ..setAttribute(
            "download",
            // Generate a somewhat unique filename
            "parameters-${DateTime.now().millisecondsSinceEpoch}.png",
          );

        // 5. Programmatically click the anchor to trigger the download
        // Append to body, click, then remove is a common pattern,
        // though sometimes direct click() works.
        html.document.body?.append(anchor);
        anchor.click();
        anchor.remove(); // Clean up the element

        debugPrint('Download initiated.');
      } catch (e) {
        debugPrint('Error initiating download: $e');
        Get.snackbar(
          'Download Error',
          'Could not download image. Error: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } else {
      debugPrint('Download function is intended for web only.');
      // Optionally show a message on non-web platforms
      Get.snackbar(
        'Download Unavailable',
        'This feature is only available on the web version.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }
}
