import 'package:flutter/material.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: RichText(
        text: TextSpan(
          text:
              'আসসালামু আলাইকুম। সহমত ভাইয়ের এলাকায় স্বাগতম। ইন্টেরিম সরকার গঠিত ​জাতীয় ঐকমত্য কমিশন বাংলাদেশে কাঠামোগত সংস্কার নিয়ে কাজ করছে। এই কমিশন বিভিন্ন সংস্কার কমিশনের সুপারিশগুলো একটা স্প্রেডশিট দিয়ে রাজনৈতিক দলগুলোর কাছে পাঠিয়ে এবং তাদের মতামত নিয়েছে। DespicableApp এর তৈরি এই ওয়েব অ্যাপে জানান আপনার মত। তারপর দেখে নিন কোন দল এর সাথে আপনার ভাবনা মিলছে। আর শেয়ার করুন আপনার বন্ধুদের সাথেও।\n Stay Despicable!',
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
        textAlign: TextAlign.center,
        softWrap: true,
        overflow: TextOverflow.visible,
        maxLines: null,
      ),
    );
  }
}

class TopTitleWidget extends StatelessWidget {
  const TopTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'সহমত ভাই',
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: '  by DespicableApp',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
