import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {

  static const heading = TextStyle(
    fontFamily: 'Gilroy',  // need to purchase - Gilroy font
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 38 / 28,
    color: AppColors.textPrimary,
  );

  static const label = TextStyle(
    fontFamily: 'Gilroy',  // need to purchase - Gilroy font
    fontSize: 15,
    fontWeight: FontWeight.w600,
    // height: 1,
    color: AppColors.textPrimary,
  );

  static const subHeading = TextStyle(
    fontFamily: 'Inter',
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static const subHeading2 = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static const buttonText = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
