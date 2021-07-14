import 'package:get/get.dart';

class AppController extends GetxController {
  var isLoggedIn = false.obs;

  setLoginStatus(bool isLogin) {
    isLoggedIn.value = isLogin;
  }
}
