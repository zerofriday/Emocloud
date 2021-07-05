import 'package:cloud/app/constants/app_colors.dart';
import 'package:cloud/app/data/models/ExplorerItem.dart';
import 'package:cloud/app/features/explorer/explorer.controller.dart';
import 'package:cloud/app/features/explorer/widgets/empty_view.dart';
import 'package:cloud/app/features/explorer/widgets/item.dart';
import 'package:cloud/app/features/explorer/widgets/select_mode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Explorer extends GetView<ExplorerController> {
  buildDividerLine() {
    return Divider(
      height: 1,
      color: AppColors.greyLight,
    );
  }

  buildAppBar() {
    return Padding(
      padding: EdgeInsets.only(top: 12, right: 12, left: 12, bottom: 24),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            "assets/images/logo.png",
            width: 40,
            height: 40,
          ),
          Padding(
              padding: EdgeInsetsDirectional.only(start: 12),
              child: Text("EmoCloud",
                  style: TextStyle(color: AppColors.dark, fontSize: 22)))
        ],
      ),
    );
  }

  buildBackButton() {
    return GestureDetector(
      onTap: () => controller.backDirectory(),
      child: Container(
        margin: EdgeInsetsDirectional.only(start: 12),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Color(0xff45D7D7)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 4.0),
              child: SvgPicture.asset(
                "assets/icons/back.svg",
                color: Colors.white,
                width: 14,
              ),
            ),
            Text(
              "back",
              style: TextStyle(color: Colors.white, fontSize: 10),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.onWillPop(),
      child: Scaffold(
        floatingActionButton: Obx(() => AnimatedOpacity(
              opacity: controller.selectingMode.value ? 0 : 1,
              duration: Duration(milliseconds: 500),
              child: FloatingActionButton(
                onPressed: () => controller.addNewFile(),
                child: const Icon(Icons.add),
                backgroundColor: AppColors.brand,
              ),
            )),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  buildAppBar(),
                  ListView(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      Obx(() => controller.selectingMode.value
                          ? selectModeTopActions(
                              cancelSelectMode: () =>
                                  controller.toggleSelectMode(false),
                              selectedLength: controller.selectedItems.length,
                              selectAllAction: () =>
                                  controller.selectAllAction())
                          : SizedBox()),
                      Obx(
                        () => Row(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12, bottom: 12, top: 12),
                                  child: Text(
                                    "/${controller.getFullDirectoryForView()}",
                                    style: TextStyle(
                                        color: Color(0xff4E4E4E),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300),
                                  ),
                                )),
                            controller.currentDirectory.value == "/"
                                ? SizedBox()
                                : buildBackButton()
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Obx(() {
                      // ignore: unnecessary_statements
                      [
                        controller.selectedItems.value,
                        controller.selectingMode.value
                      ];
                      return controller.currentDirectoryFiles.length > 0
                          ? ListView.separated(
                              padding: EdgeInsets.only(bottom: 80),
                              separatorBuilder: (context, index) => Padding(
                                    padding: EdgeInsets.only(
                                        left: 12, right: 12, top: 8, bottom: 8),
                                    child: buildDividerLine(),
                                  ),
                              physics: BouncingScrollPhysics(),
                              itemCount:
                                  controller.currentDirectoryFiles.length,
                              itemBuilder: (_, index) {
                                ExplorerItem item = controller
                                    .currentDirectoryFiles[index];
                                Color iconColor =
                                    controller.getIconColor(item.extension);

                                return ExplorerFileItem(
                                  item,
                                  longPress: () {
                                    controller.toggleSelectMode(true);
                                    controller.selectItem(item);
                                  },
                                  onTap: () => controller.selectItem(item),
                                  isSelected:
                                      controller.isSelectedItem(item.path),
                                  selectMode: controller.selectingMode.value,
                                  extensionColor: iconColor,
                                );
                              })
                          : emptyView();
                    }),
                  )
                ],
              ),
              Positioned(
                child: Obx(() => controller.selectingMode.value
                    ? selectModeBottomActions(
                        deleteAction: () => controller.deleteActionAlert())
                    : SizedBox()),
                bottom: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
