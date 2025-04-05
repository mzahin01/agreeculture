import 'dart:math';
import 'package:flutter/material.dart';
import '../controllers/result_show_controller.dart';

class ShareButtonWidget extends StatelessWidget {
  const ShareButtonWidget({super.key, required this.controller});

  final ResultShowController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: min(double.maxFinite, 600),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextButton(
        onPressed: () {
          controller.shareInfo();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.share, color: Colors.white, size: 30),
            const SizedBox(width: 20),
            const Text(
              'Share Result',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
