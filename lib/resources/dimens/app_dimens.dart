import 'package:flutter/material.dart';
import 'dart:math' as math;

class Dimens {
  const Dimens._();
  static late double ratioHeight;
  static late double ratioWidth;
  static late double scaleFontsize;

  // define height reponsive screen
  static late final SizedBox h10;
  static late final SizedBox h5;
  static late final SizedBox h4;
  static late final SizedBox h6;
  static late final SizedBox h8;
  static late final SizedBox h12;
  static late final SizedBox h14;
  static late final SizedBox h16;
  //
  // define width reponsive screen
  static late final SizedBox w10;
  static late final SizedBox w5;
  static late final SizedBox w4;
  static late final SizedBox w6;
  static late final SizedBox w8;
  static late final SizedBox w12;
  static late final SizedBox w14;
  static late final SizedBox w16;
  static void handleRatioScreen(Size size) {
    ratioWidth = size.width / 374;
    ratioHeight = size.height / 812;
    scaleFontsize = math.min(ratioWidth, ratioHeight);
    if (scaleFontsize >= 1) {
      scaleFontsize = 1;
    } else {
      scaleFontsize = 0.85;
    }
    h4 = SizedBox(
      height: 4 * ratioHeight,
    );
    h5 = SizedBox(
      height: 5 * ratioHeight,
    );
    h6 = SizedBox(
      height: 6 * ratioHeight,
    );
    h8 = SizedBox(
      height: 8 * ratioHeight,
    );
    h10 = SizedBox(
      height: 10 * ratioHeight,
    );
    h10 = SizedBox(
      height: 12 * ratioHeight,
    );
    h12 = SizedBox(
      height: 12 * ratioHeight,
    );
    h14 = SizedBox(
      height: 12 * ratioHeight,
    );
    h16 = SizedBox(
      height: 12 * ratioHeight,
    );
    w4 = SizedBox(
      width: 4 * ratioWidth,
    );

    w5 = SizedBox(
      width: 5 * ratioWidth,
    );
    w6 = SizedBox(
      width: 6 * ratioWidth,
    );
    w8 = SizedBox(
      width: 8 * ratioWidth,
    );
    w10 = SizedBox(
      width: 10 * ratioWidth,
    );
    w12 = SizedBox(
      width: 12 * ratioWidth,
    );
    w14 = SizedBox(
      width: 14 * ratioWidth,
    );
    w16 = SizedBox(
      width: 16 * ratioWidth,
    );
  }
}
