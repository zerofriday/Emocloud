import 'package:cloud/app/constants/app_colors.dart';
import 'package:cloud/app/data/models/ExplorerItem.dart';
import 'package:cloud/app/utils/formatBytes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'common.dart';

decryptDialog(
    {var passwordController,
    String extension = "",
    Color? color,
    String name = "",
    Function? pickOutputDirectory,
    String selectedOutputDirectory = "",
    int size = 0}) {
  return Column(
    children: [
      Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(start: 8, end: 12),
              child: buildFileIcon(color: color, extension: extension),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$name",
                      style: TextStyle(fontSize: 12, color: AppColors.dark),
                      overflow: TextOverflow.ellipsis),
                  Text(
                    formatBytes(size, 1),
                    style: TextStyle(
                      color: AppColors.grey2,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            )
          ]),
      Padding(
        padding: EdgeInsets.only(right: 12, left: 12, top: 12),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Enter your Password",
            style: TextStyle(fontSize: 12, color: AppColors.grey1),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(right: 12, left: 12, top: 8),
        child: Container(
          padding: EdgeInsets.only(left: 12, right: 12),
          decoration: BoxDecoration(
            color: AppColors.greyLight,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: passwordController,
            decoration: InputDecoration(
                border: InputBorder.none,
                icon: SvgPicture.asset(
                  "assets/icons/lock.svg",
                  width: 15,
                  height: 15,
                  color: AppColors.dark,
                ),
                hintText: "*******"),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(right: 12, left: 12, top: 12),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "select extract path",
            style: TextStyle(fontSize: 12, color: AppColors.grey1),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(right: 12, left: 12, top: 8),
        child: GestureDetector(
          onTap: () => pickOutputDirectory!(),
          child: Container(
            padding: EdgeInsets.only(left: 12, right: 12),
            decoration: BoxDecoration(
              color: AppColors.greyLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8.0),
                  child: SvgPicture.asset(
                    "assets/icons/lock.svg",
                    width: 15,
                    height: 15,
                    color: AppColors.dark,
                  ),
                ),
                Expanded(
                  child: Text(selectedOutputDirectory,
                  overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
