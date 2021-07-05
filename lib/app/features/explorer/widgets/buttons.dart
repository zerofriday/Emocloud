import 'package:cloud/app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

okButton(String title, Function action) {
  return TextButton(
    onPressed: () => action(),
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.action),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ))),
    child: Text(
      title,
      style: TextStyle(color: Colors.white),
    ),
  );
}

cancelButton(String title, Function action) {
  return TextButton(
    onPressed: () => action(),
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.greyLight),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ))),
    child: Text(
      title,
      style: TextStyle(color: AppColors.dark),
    ),
  );
}
