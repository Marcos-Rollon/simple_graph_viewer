import 'package:flutter/material.dart';
import 'app_sizes.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

abstract class AppButtonStyles {
  // Theme data
  static final TextButtonThemeData standartTextButtonTheme =
      TextButtonThemeData(style: AppButtonStyles.textM);
  static final OutlinedButtonThemeData standartOutlinedButtonTheme =
      OutlinedButtonThemeData(style: AppButtonStyles.outlineM);
  static final ElevatedButtonThemeData standartElevatedButtonTheme =
      ElevatedButtonThemeData(style: AppButtonStyles.elevatedM);

  // Text buttons
  static final ButtonStyle textM = TextButton.styleFrom(
    textStyle: AppTextStyles.p,
    foregroundColor: AppColors.mainTextColor,
  );
  static final ButtonStyle textL = TextButton.styleFrom(
    textStyle: AppTextStyles.h3,
  );
  static final ButtonStyle textSecondary = TextButton.styleFrom(
    textStyle: AppTextStyles.pSecondary,
    foregroundColor: AppColors.secondaryTextColor,
  );

  // Outline Buttons
  static final ButtonStyle outlineM = OutlinedButton.styleFrom(
    textStyle: AppTextStyles.p,
    foregroundColor: AppColors.white,
    side: const BorderSide(color: AppColors.white, width: 2),
  );
  static final ButtonStyle outlineL = OutlinedButton.styleFrom(
    textStyle: AppTextStyles.h3,
  );
  static final ButtonStyle outlineRound = OutlinedButton.styleFrom(
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: AppColors.white),
      borderRadius: BorderRadius.circular(99),
    ),
  );
  static final ButtonStyle outlineRoundL = OutlinedButton.styleFrom(
    textStyle: AppTextStyles.h3,
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: AppColors.white),
      borderRadius: BorderRadius.circular(99),
    ),
  );

  static final ButtonStyle outlineSecondary = OutlinedButton.styleFrom(
    foregroundColor: AppColors.secondaryTextColor,
  );

  // Elevated buttons
  static final ButtonStyle elevatedM = ElevatedButton.styleFrom(
    foregroundColor: AppColors.white,
    backgroundColor: AppColors.main,
    surfaceTintColor: AppColors.enfasis,
    textStyle: AppTextStyles.p,
    elevation: 20,
    shadowColor: AppColors.black,
  );
  static final ButtonStyle elevatedL = ElevatedButton.styleFrom(
    textStyle: AppTextStyles.h3.copyWith(fontWeight: FontWeight.normal),
    surfaceTintColor: AppColors.main,
    padding: AppSizes.elementPaddingM,
  );
  static final ButtonStyle elevatedXL = ElevatedButton.styleFrom(
    textStyle: AppTextStyles.h2.copyWith(fontWeight: FontWeight.normal),
    surfaceTintColor: AppColors.main,
    padding: AppSizes.elementPaddingM,
  );
  static final ButtonStyle elevatedRound = ElevatedButton.styleFrom(
    backgroundColor: AppColors.enfasis,
    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(99),
    ),
  );
  static final ButtonStyle elevatedSecondary = ElevatedButton.styleFrom(
    foregroundColor: AppColors.secondaryTextColor,
    surfaceTintColor: AppColors.main,
  );

  static ButtonStyle elevatedXLWithMinWidth(double width) {
    return ElevatedButton.styleFrom(
      minimumSize: Size(width, 10),
      textStyle: AppTextStyles.h2.copyWith(fontWeight: FontWeight.normal),
    );
  }
}
