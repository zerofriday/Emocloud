import 'package:cloud/app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

emptyView() {
  return Padding(
    padding: const EdgeInsets.only(top: 48.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          "assets/icons/shield.svg",
          width: 80,
          height: 80,
          color: AppColors.grey1,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text(
            "Secure Your First File!",
            style: TextStyle(color: AppColors.grey1, fontSize: 16),
          ),
        )
      ],
    ),
  );
}
