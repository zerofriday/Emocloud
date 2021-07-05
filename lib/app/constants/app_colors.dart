import 'package:flutter/material.dart';

abstract class AppColorsSchema {
  late Color brand;
  late Color grey1;
  late Color grey2;
  late Color greyLight;
  late Color dark;
  late Color action;
}

class AppColorsLight extends AppColorsSchema {
  Color brand = Color(0xff57C7F6);
  Color grey1 = Color(0xff818181);
  Color grey2 = Color(0xffC4C4C4);
  Color greyLight = Color(0xffF0F0F0);
  Color dark = Color(0xff2C2C2C);
  Color action = Color(0xff45D7D7);
}
// ignore: non_constant_identifier_names
var AppColors=new AppColorsLight();