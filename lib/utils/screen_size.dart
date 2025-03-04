import 'package:flutter/material.dart';

class ScreenUtil {
  static late double width;
  static late double height;

  static void init(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    width = screenSize.width;
    height = screenSize.height;
  }
}
