import 'package:cloud/app/controllers/GetXNetworkManager.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  @override
  void onReady() {
    Get.put(GetXNetworkManager(), permanent: true);
    super.onReady();
  }
}
