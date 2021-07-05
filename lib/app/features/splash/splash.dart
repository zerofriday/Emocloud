import 'package:cloud/app/constants/app_colors.dart';
import 'package:cloud/app/constants/config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Splash extends GetView {
  @override
  Widget build(BuildContext context) {
    final logoSize = Get.width * 0.43;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: logoSize,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    "Emo Cloud",
                    style: TextStyle(
                        color: AppColors.dark,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                )
              ],
            )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Text(
                  APP_VERSION,
                  style: TextStyle(fontSize: 18, color: AppColors.dark),
                ),
              ),
            ),
            Positioned(
                top: 0,
                right: 0,
                child: SvgPicture.asset(
                  "assets/images/splash_right_edge.svg",
                  width: Get.width * 0.35,
                  height: Get.height * 0.35,
                )),
            Positioned(
                top: (Get.height * 0.35) - (Get.height * 0.2 / 2),
                left: 0,
                child: SvgPicture.asset(
                  "assets/images/splash_left_edge.svg",
                  width: Get.width * 0.25,
                  height: Get.height * 0.23,
                )),
            Positioned(
                bottom: 0,
                left: 0,
                child: SvgPicture.asset(
                  "assets/images/splash_bottom_edge.svg",
                  width: Get.width * 0.48,
                ))
          ],
        ));
  }
}
