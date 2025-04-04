import 'package:get/get.dart';

import '../modules/credit_and_about_us/bindings/credit_and_about_us_binding.dart';
import '../modules/credit_and_about_us/views/credit_and_about_us_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/result_show/bindings/result_show_binding.dart';
import '../modules/result_show/views/result_show_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CREDIT_AND_ABOUT_US,
      page: () => const CreditAndAboutUsView(),
      binding: CreditAndAboutUsBinding(),
    ),
    GetPage(
      name: _Paths.RESULT_SHOW,
      page: () => const ResultShowView(),
      binding: ResultShowBinding(),
    ),
  ];
}
