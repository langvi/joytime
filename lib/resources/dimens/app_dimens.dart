import 'package:flutter/material.dart';
import 'dart:math' as math;

class Dimens {
  const Dimens._();
  static late double ratioHeight;
  static late double ratioWidth;
  static late double scaleFontsize;

  // define height reponsive screen
  static late final double h10;
  static late final double h5;
  static late final double h4;
  static late final double h6;
  static late final double h8;
  static late final double h12;
  static late final double h14;
  static late final double h16;
  //
  // define width reponsive screen
  static late final double w10;
  static late final double w5;
  static late final double w4;
  static late final double w6;
  static late final double w8;
  static late final double w12;
  static late final double w14;
  static late final double w16;
  static void handleRatioScreen(Size size) {
    ratioWidth = size.width / 374;
    ratioHeight = size.height / 812;
    scaleFontsize = math.min(ratioWidth, ratioHeight);
    if (scaleFontsize >= 1) {
      scaleFontsize = 1;
    } else {
      scaleFontsize = 0.85;
    }
    h4 = 4 * ratioHeight;
    h5 = 5 * ratioHeight;
    h6 = 6 * ratioHeight;
    h8 = 8 * ratioHeight;
    h10 = 10 * ratioHeight;
    h12 = 12 * ratioHeight;
    h14 = 14 * ratioHeight;
    h16 = 16 * ratioHeight;
    //
    w4 = 4 * ratioWidth;
    w5 = 5 * ratioWidth;
    w6 = 6 * ratioWidth;
    w8 = 8 * ratioWidth;
    w10 = 10 * ratioWidth;
    w12 = 12 * ratioWidth;
    w14 = 14 * ratioWidth;
    w16 = 16 * ratioWidth;
  }
}
