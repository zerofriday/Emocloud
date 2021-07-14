import 'dart:io';

import 'package:cloud/app/constants/app_colors.dart';
import 'package:cloud/app/data/models/ExplorerItem.dart';
import 'package:cloud/app/features/explorer/widgets/buttons.dart';
import 'package:cloud/app/features/explorer/widgets/common.dart';
import 'package:cloud/app/features/explorer/widgets/decrypt_dialog.dart';
import 'package:cloud/app/features/explorer/widgets/encrypt_dialog.dart';
import 'package:cloud/app/utils/aes_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:permission_handler/permission_handler.dart';
import "package:path/path.dart" as p;

class ExplorerController extends GetxController {
  var selectingMode = false.obs;
  var selectedItems = [].obs;
  var currentDirectoryFiles = [].cast<ExplorerItem>().obs;
  var currentDirectory = "/".obs;
  String basePath = "/storage/emulated/0/";
  String emoBaseName = "emo-cloud";
  var isAddModalOpen = false.obs;

  var selectedFilePath = "".obs;
  var passwordBoxController = TextEditingController();
  var encryptFileLoading = false.obs;

  var selectedOutputDirectory = "".obs;

  // todo : change this later
  var passPrefix = "1234567891234567891234567891";

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    // load files and folders list
    requestExternalPermission().then((_) async {
      await createEmoBasePath();
      await loadDirectoryFiles();
    });
  }

  String getEmoHomeFullPath() {
    return "$basePath$emoBaseName";
  }

  String getCurrentFullPath() {
    return getEmoHomeFullPath() + currentDirectory.value;
  }

  String getFullDirectoryForView() {
    return getCurrentFullPath().replaceAll(basePath, "");
  }

  addNewFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path ?? "");
      selectedFilePath.value = file.path;
      openAddNewFileModal();
    }
    isAddModalOpen.value = true;
  }

  getEncryptedFileExtension(String path) {
    var extension = "";
    if (path.contains(".aes")) {
      extension = p.extension(path.replaceAll(".aes", ""));
    } else {
      extension = p.extension(path);
    }
    return extension;
  }

  cancelAddFile() {
    selectedFilePath.value = "";
    Get.back();
  }

  openAddNewFileModal() {
    File file = File(selectedFilePath.value);
    var ext = p.extension(file.path).replaceAll(".", "");

    Get.defaultDialog(
      title: "Add new file",
      titleStyle: TextStyle(fontSize: 16),
      content: encryptDialog(
          name: p.basename(file.path),
          extension: ext,
          passwordController: passwordBoxController,
          color: getIconColor(ext),
          size: file.lengthSync()),
      actions: [
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(right: 12, left: 12),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: okButton("Encrypt", doEncryptSelectedFile)),
              SizedBox(
                width: 12,
              ),
              Expanded(child: cancelButton("Cancel", cancelAddFile))
            ],
          ),
        )
      ],
    );
  }

  pickOutputDirectory() async {
    String path = await FilesystemPicker.open(
      title: 'Save to folder',
      context: Get.context as BuildContext,
      rootDirectory: Directory(basePath),
      fsType: FilesystemType.folder,
      pickText: 'Save file folder',
      folderIconColor: AppColors.brand,
    );
    if (path != "") {
      selectedOutputDirectory.value = path;
    }
  }

  openDecryptModal() {
    selectedOutputDirectory.value = "${basePath}Download";
    File file = File(selectedFilePath.value);
    var ext = p.extension(file.path.replaceAll(".aes", "")).replaceAll(".", "");

    Get.defaultDialog(
      title: "Decrypt File",
      titleStyle: TextStyle(fontSize: 16),
      content: decryptDialog(
          selectedOutputDirectory: selectedOutputDirectory.value,
          pickOutputDirectory: pickOutputDirectory,
          name: p.basename(file.path),
          extension: ext,
          passwordController: passwordBoxController,
          color: getIconColor(ext),
          size: file.lengthSync()),
      actions: [
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(right: 12, left: 12),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: okButton("Decrypt", doDecryptSelectedFile)),
              SizedBox(
                width: 12,
              ),
              Expanded(child: cancelButton("Cancel", cancelAddFile))
            ],
          ),
        )
      ],
    );
  }

  doDecryptSelectedFile() {
    var pureName = p.basename(selectedFilePath.value).replaceAll(".aes", "");
    var outputFile = selectedOutputDirectory.value + pureName;
    Map params = {
      "file": selectedFilePath.value,
      "outFile": outputFile,
      "key": "$passPrefix${passwordBoxController.text}"
    };

    Get.dialog(
      loadingDialog("Decrypting"),
      barrierDismissible: false,
    );
    compute(decryptFile, params).then((res) {
      loadDirectoryFiles();
      encryptFileLoading.value = false;
      Get.back(closeOverlays: true);
      Get.showSnackbar(GetBar(
        message: "file saved !",
      ));
    }).catchError((_) {
      Get.showSnackbar(GetBar(
        message: "a problem occurred",
      ));
    });
  }

  generateAesOutputName(String path) {
    var name = p.basename(path) + ".aes";
    return name;
  }

  doEncryptSelectedFile() {
    var outputFile = getCurrentFullPath() +
        "/" +
        generateAesOutputName(selectedFilePath.value);
    Map params = {
      "file": selectedFilePath.value,
      "outFile": outputFile,
      "key": "$passPrefix${passwordBoxController.text}"
    };

    Get.dialog(
      loadingDialog("Encrypting"),
      barrierDismissible: false,
    );
    compute(encryptFile, params).then((res) {
      loadDirectoryFiles();
      Get.back(closeOverlays: true);
    });
  }

  deleteAction() async {
    // do delete action
    Get.back();
    try {
      var deleteLength = selectedItems.length;
      selectedItems.forEach((path) async {
        if (FileSystemEntity.isDirectorySync(path) &&
            Directory(path).existsSync()) {
          await Directory(path).delete(recursive: true);
        } else {
          if (File(path).existsSync()) {
            await File(path).delete();
          }
        }
      });
      selectingMode.value = false;
      selectedItems.clear();
      await loadDirectoryFiles();
      Get.showSnackbar(GetBar(
        message: "$deleteLength items deleted",
        duration: Duration(milliseconds: 1500),
      ));
    } catch (_) {
      Get.showSnackbar(GetBar(
        message: "a problem occurred ",
        duration: Duration(milliseconds: 1500),
      ));
    }
  }

  deleteActionAlert() {
    Get.defaultDialog(
      title: "Delete Confirm",
      cancel: TextButton(
        onPressed: () => deleteAction(),
        child: Text("Yes"),
      ),
      confirm: TextButton(
        onPressed: () => Get.back(),
        child: Text(
          "cancel",
          style: TextStyle(color: Colors.red),
        ),
      ),
      content: Text(
        "Are you sure ?",
      ),
    );
  }

  loadDirectoryFiles() async {
    List<ExplorerItem> list = [];

    List<FileSystemEntity> filesList =
        Directory(getCurrentFullPath()).listSync();

    for (var item in filesList) {
      String? ext;
      String name = p.basename(item.path);
      String path = item.path;

      File file = File(path);
      bool isDirectory = await FileSystemEntity.isDirectory(path);
      int filesCount = 0;
      if (isDirectory) {
        filesCount = Directory(path).listSync().length;
      } else {
        ext = getEncryptedFileExtension(item.path).replaceAll(".", "");
      }
      if (ext != null) {
        name = name.replaceAll(".$ext", "");
        name = name.replaceAll(".aes", "");
      }
      list.add(ExplorerItem(
          extension: ext,
          name: name,
          path: path,
          itemsLength: isDirectory ? filesCount : 0,
          size: isDirectory ? 0 : file.lengthSync(),
          isDirectory: isDirectory));
    }
    currentDirectoryFiles.value = list;
  }

  selectAllAction() {
    // if all checked
    if (selectedItems.length == currentDirectoryFiles.length) {
      selectedItems.clear();
    } else {
      currentDirectoryFiles.forEach((element) {
        if (!isSelectedItem(element.path)) {
          selectedItems.add(element.path);
        }
      });
    }
  }

  createEmoBasePath() async {
    Directory dir = Directory(getEmoHomeFullPath());
    if (!(await dir.exists())) {
      await dir.create();
    }
  }

  Future requestExternalPermission() async {
    if (await Permission.storage.request().isGranted) {
      return Future.value(true);
    }
    return Future.value(false);
  }

  toggleSelectMode(bool show) {
    if (!show) {
      this.selectedItems.clear();
    }
    selectingMode.value = show;
  }

  normalizeInnerDirectoryPath(String path) {
    return path.replaceAll(getEmoHomeFullPath(), "");
  }

  goToDirectory(String path) async {
    currentDirectory.value = normalizeInnerDirectoryPath(path);
    await loadDirectoryFiles();
  }

  backDirectory() async {
    String prevName = Directory(currentDirectory.value).parent.path;
    prevName = normalizeInnerDirectoryPath(prevName);
    currentDirectory.value = prevName;
    await loadDirectoryFiles();
  }

  selectItem(ExplorerItem item) {
    if (!selectingMode.value) {
      tappedItem(item);
      return false;
    }
    bool isSelected = isSelectedItem(item.path);
    if (!isSelected) {
      selectedItems.add(item.path);
    } else {
      selectedItems.remove(item.path);
    }
  }

  tappedItem(ExplorerItem item) {
    if (item.isDirectory) {
      goToDirectory(item.path);
      return;
    }
    selectedFilePath.value = item.path;
    openDecryptModal();
  }

  isSelectedItem(String path) {
    return selectedItems.contains(path);
  }

  getIconColor(String? type) {
    if (type != null) {
      if (typesColor.containsKey(type)) {
        return typesColor[type];
      } else {
        return typesColor["any"];
      }
    }
    return typesColor["directory"];
  }

  onWillPop() {
    if (selectingMode.isTrue) {
      toggleSelectMode(false);
      return false;
    }
    if (currentDirectory.isNotEmpty) {
      backDirectory();
      return false;
    }
  }

  Map<String, Color> typesColor = {
    "png": Color(0xff58E9C6),
    "jpeg": Color(0xff58E9C6),
    "jpg": Color(0xff58E9C6),
    "any": Color(0xffDADADA),
    "directory": Color(0xffFFD19A),
  };
}
