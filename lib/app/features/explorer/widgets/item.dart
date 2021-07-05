import 'package:cloud/app/constants/app_colors.dart';
import 'package:cloud/app/data/models/ExplorerItem.dart';
import 'package:cloud/app/utils/formatBytes.dart';
import 'package:cloud/app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExplorerFileItem extends StatelessWidget {
  final ExplorerItem item;
  bool selectMode;
  bool isSelected;
  Function? onTap;
  Function? longPress;
  bool isSynced;
  Function? onSyncTap;
  Color extensionColor;

  ExplorerFileItem(this.item,
      {this.selectMode = false,
      this.onTap,
      this.isSynced = false,
      this.onSyncTap,
      this.longPress,
      this.isSelected = false,
      this.extensionColor = const Color(0xffDADADA)});

  buildIcon() {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
          color: this.extensionColor, borderRadius: BorderRadius.circular(8)),
      child: Center(
          child: item.isDirectory
              ? SvgPicture.asset(
                  "assets/icons/folder.svg",
                  color: Colors.white,
                  width: 28,
                )
              : item.extension != null
                  ? Text(
                      capitalize(item.extension?.toLowerCase() ?? ""),
                      style: TextStyle(fontSize: 10),
                    )
                  : SizedBox()),
    );
  }

  buildSyncIcon() {
    return GestureDetector(
      onTap: () => this.onSyncTap!(),
      child: SvgPicture.asset(
        "assets/icons/refresh-line.svg",
        width: 20,
        height: 20,
        color: Color(0xff8C8C8C),
      ),
    );
  }

  buildSelectIcon() {
    return this.isSelected
        ? SvgPicture.asset(
            "assets/icons/selected.svg",
            width: 20,
            height: 20,
          )
        : SvgPicture.asset(
            "assets/icons/not_selected.svg",
            width: 20,
            height: 20,
            color: Color(0xff8C8C8C),
          );
  }

  @override
  Widget build(BuildContext context) {
    String underNameText = "";
    if (item.isDirectory) {
      underNameText = "${item.itemsLength} items";
    } else {
      underNameText = formatBytes(item.size, 1);
    }
    String extension = "";
    if (!item.isDirectory) {
      extension = ".${item.extension}";
    }
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => this.onTap!(),
      onLongPress: () => this.longPress!(),
      child: Padding(
        padding: EdgeInsets.only(right: 12, left: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 5,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: 8, end: 12),
                      child: buildIcon(),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${item.name}${extension}",
                              style: TextStyle(
                                  fontSize: 12, color: AppColors.dark),
                              overflow: TextOverflow.ellipsis),
                          Text(
                            underNameText,
                            style: TextStyle(
                              color: Color(0xff959595),
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
            ),
            Flexible(
                child: Align(
              alignment: Alignment.centerRight,
              child: this.selectMode ? buildSelectIcon() : buildSyncIcon(),
            ))
          ],
        ),
      ),
    );
  }
}
