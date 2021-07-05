import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

selectModeBottomActions({deleteAction: Function}) {
  return Container(
    width: Get.width,
    padding: EdgeInsets.only(top: 8, bottom: 8),
    color: Color(0xffF0F0F0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Material(
          color: Colors.transparent,
          child: InkResponse(
            radius: 25,
            borderRadius: BorderRadius.circular(50),
            onTap: () => deleteAction(),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/trash.svg",
                    width: 24,
                    height: 24,
                    color: Color(0xff141414),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      "Delete",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
}

selectModeTopActions(
    {int selectedLength = 0,
    Function? selectAllAction,
    Function? cancelSelectMode}) {
  return Container(
    padding: EdgeInsets.only(bottom: 8, top: 8),
    color: Color(0xffEBEBEB),
    child: Padding(
      padding: EdgeInsets.only(right: 12, left: 12, bottom: 8, top: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => cancelSelectMode!(),
            child: SvgPicture.asset(
              "assets/icons/close.svg",
              width: 20,
              height: 20,
              color: Color(0xff4E4E4E),
            ),
          ),
          Text("selected $selectedLength items"),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => selectAllAction!(),
            child: SvgPicture.asset(
              "assets/icons/check_all.svg",
              width: 22,
              height: 22,
              color: Color(0xff4E4E4E),
            ),
          ),
        ],
      ),
    ),
  );
}
