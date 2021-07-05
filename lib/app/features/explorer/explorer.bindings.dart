import 'package:cloud/app/features/explorer/explorer.controller.dart';
import 'package:get/get.dart';

class ExplorerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ExplorerController());
  }
}
