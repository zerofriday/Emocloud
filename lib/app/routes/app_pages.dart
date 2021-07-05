import 'package:cloud/app/features/explorer/explorer.bindings.dart';
import 'package:cloud/app/features/explorer/explorer.dart';
import 'package:cloud/app/features/main/main.dart';
import 'package:cloud/app/features/splash/splash.bindings.dart';
import 'package:cloud/app/features/splash/splash.dart';
import 'package:cloud/app/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.INITIAL,
      binding: SplashBinding(),
      page: () => Splash(),
    ),
    GetPage(
      name: Routes.MAIN,
      page: () => Main(),
    ),
    GetPage(
      name: Routes.EXPLORER,
      binding: ExplorerBindings(),
      page: () => Explorer(),
    ),
  ];
}
