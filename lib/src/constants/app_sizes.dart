import 'package:flutter/material.dart';

class AppSizes {
  AppSizes._();

  // Util widgets
  // Padding
  static const EdgeInsetsGeometry pagePadding =
      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0);
  static const EdgeInsetsGeometry elementMargingM =
      EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0);

  static const EdgeInsetsGeometry elementPaddingS =
      EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0);
  static const EdgeInsetsGeometry elementPaddingM =
      EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0);
  static const EdgeInsetsGeometry elementPaddingL =
      EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0);
  static const EdgeInsetsGeometry elementPaddingXL =
      EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0);
  // Spacers
  static const SizedBox verticalSpacerXS =
      SizedBox(height: AppSizes.elementSeparationXS);
  static const SizedBox verticalSpacerS =
      SizedBox(height: AppSizes.elementSeparationS);
  static const SizedBox verticalSpacerM =
      SizedBox(height: AppSizes.elementSeparationM);
  static const SizedBox verticalSpacerL =
      SizedBox(height: AppSizes.elementSeparationL);

  static const SizedBox horizontalSpacerXS =
      SizedBox(width: AppSizes.elementSeparationXS);
  static const SizedBox horizontalSpacerS =
      SizedBox(width: AppSizes.elementSeparationS);
  static const SizedBox horizontalSpacerM =
      SizedBox(width: AppSizes.elementSeparationM);
  static const SizedBox horizontalSpacerL =
      SizedBox(width: AppSizes.elementSeparationL);

  // Borders
  static BorderRadiusGeometry borderRadiusXS = BorderRadius.circular(4.0);
  static BorderRadiusGeometry borderRadiusS = BorderRadius.circular(6.0);
  static BorderRadiusGeometry borderRadiusM = BorderRadius.circular(12.0);
  static BorderRadiusGeometry borderRadiusL = BorderRadius.circular(18.0);
  static BorderRadiusGeometry borderRadiusInf = BorderRadius.circular(999.0);

  // Constants
  static const double logoHeightS = 42.0;
  static const double logoHeightM = 52.0;
  static const double logoHeightL = 64.0;

  static const double iconButtonS = 38.0;
  static const double iconButtonM = 48.0;
  static const double iconButtonL = 58.0;

  static const double iconAlert = 85.0;

  static const double elementSeparationXS = 6.0;
  static const double elementSeparationS = 8.0;
  static const double elementSeparationM = 12.0;
  static const double elementSeparationL = 24.0;

  static const double h1TextSize = 32.0;
  static const double h2TextSize = 28.0;
  static const double h3TextSize = 22.0;
  static const double h4TextSize = 18.0;
  static const double h5TextSize = 14.0;
  static const double pTextSize = 12.0;
  static const double psTextSize = 10.0;
  static const double pxsTextSize = 8.0;
  static const double pxxsTextSize = 4.0;
}
