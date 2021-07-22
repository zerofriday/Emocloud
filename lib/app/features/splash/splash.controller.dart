import 'package:cloud/app/routes/app_routes.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(Duration(milliseconds: 1500), () {
      Get.offNamed(Routes.AUTH);
    });
  }
}
