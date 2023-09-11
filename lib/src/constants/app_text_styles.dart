import 'package:flutter/material.dart';
import './app_colors.dart';
import './app_sizes.dart';

abstract class AppTextStyles {
  static const _baseTextColor = AppColors.mainTextColor;
  static const _baseSecondaryTextColor = AppColors.secondaryTextColor;

  static const h1 = TextStyle(
    color: _baseTextColor,
    fontSize: AppSizes.h1TextSize,
    fontWeight: FontWeight.w800,
  );
  static const h2 = TextStyle(
    color: _baseTextColor,
    fontSize: AppSizes.h2TextSize,
    fontWeight: FontWeight.bold,
  );
  static const h3 = TextStyle(
    color: _baseTextColor,
    fontSize: AppSizes.h3TextSize,
    fontWeight: FontWeight.bold,
  );
  static const h4 = TextStyle(
    color: _baseTextColor,
    fontSize: AppSizes.h4TextSize,
  );
  static const h5 = TextStyle(
    color: _baseTextColor,
    fontSize: AppSizes.h5TextSize,
  );

  static const p = TextStyle(
    color: _baseTextColor,
    fontSize: AppSizes.pTextSize,
  );
  static const pSecondary = TextStyle(
    color: _baseSecondaryTextColor,
    fontSize: AppSizes.pTextSize,
  );
  static const ps = TextStyle(
    color: _baseTextColor,
    fontSize: AppSizes.psTextSize,
  );
  static const psSecondary = TextStyle(
    color: _baseSecondaryTextColor,
    fontSize: AppSizes.psTextSize,
  );
}
