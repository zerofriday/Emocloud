import 'package:flutter/material.dart';

import 'constants/app_colors.dart';

submitButton(String text, Function onTap, {bool isLoading = false}) {
  return  InkWell(
      onTap: () => onTap(),
      borderRadius: BorderRadius.circular(8),
        splashColor: AppColors.brand,
      child: Container(
        height: 56,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                colors: [AppColors.brand, AppColors.brand.withOpacity(0.6)],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              )),
          child: Center(
            child: isLoading
                ? CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 1.5,
            )
                : Text(
                    text,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
          )),

  );
}
