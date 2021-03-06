import 'package:cloud/app/controllers/app.controller.dart';
import 'package:cloud/app/controllers/auth.controller.dart';
import 'package:cloud/app/features/splash/splash.controller.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AppController(), permanent: true);
    Get.put(SplashController());
    Get.put(AuthController(), permanent: true);
  }
}
