import 'package:cloud/app/constants/app_colors.dart';
import 'package:cloud/app/features/main/main.controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Main extends GetView {
  MainController controller = Get.put(MainController());

  TextEditingController _passwordController = TextEditingController();
  String? fileDir = "";

  selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result?.files != null && result?.files.single.path != null) {
      String? filePath = result?.files.single.path;
      if (filePath != null) {
        controller.selectedFile.value = filePath;
      }
    } else {
      print("user canceled");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawerEdgeDragWidth: 150,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, top: 12),
        child: Column(
          children: [

          ],
        ),
      )),
    );
  }
}
