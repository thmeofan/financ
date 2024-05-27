import 'package:flutter/material.dart';

import '../app_colors.dart';

class OperationTextStyle {
  static TextStyle switchStyle = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 18.0,
    height: 20 / 18,
    fontWeight: FontWeight.w500,
    //  color: AppColors.darkGreyColor,
  );
  static TextStyle income = const TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 20.0,
    height: 24 / 20,
    fontWeight: FontWeight.w600,
    color: AppColors.greenColor,
  );
  static TextStyle spendings = const TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 20.0,
    height: 24 / 20,
    fontWeight: FontWeight.w600,
    color: AppColors.redColor,
  );
  static TextStyle description = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 20.0,
    height: 20 / 18,
    fontWeight: FontWeight.w400,
    // color: AppColors.darkGreyColor,
  );
  static TextStyle hint = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 16.0,
    height: 20 / 14,
    fontWeight: FontWeight.w800,
    // color: AppColors.lightGreyColor,
  );
  static const TextStyle tileSum = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 18.0,
    height: 20 / 18,
    fontWeight: FontWeight.w800,
    color: AppColors.orangeColor,
  );
  static TextStyle tileSubtitle = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 14.0,
    height: 20 / 14,
    fontWeight: FontWeight.w400,
    //color: AppColors.darkGreyColor,
  );
  static TextStyle date = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 10.0,
    height: 12 / 10,
    fontWeight: FontWeight.w400,
    // color: AppColors.darkGreyColor,
  );
}
