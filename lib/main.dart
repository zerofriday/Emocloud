import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/core/theme/app_theme.dart';
import 'app/features/splash/splash.bindings.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import "package:cloud/app/core/theme/app_theme.dart";

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialBinding: SplashBinding(),
    initialRoute: Routes.INITIAL,
    theme: appThemeData,
    defaultTransition: Transition.fade,
    getPages: AppPages.pages,
    textDirection: TextDirection.ltr,
    locale: Locale('en', 'US'),
    // translationsKeys: AppTranslation.translations,
  ));
}
