import 'package:flutter/material.dart';
import './app_sizes.dart';
import 'app_colors.dart';

abstract class AppIcons {
  static const _mainColor = AppColors.white;

  static Icon home = const Icon(Icons.home);
  static Icon community = const Icon(Icons.verified_user);

  static Widget settingsS = const Icon(
    Icons.settings,
    color: AppIcons._mainColor,
    size: AppSizes.iconButtonS,
  );
  static Widget settingsM = const Icon(
    Icons.settings,
    color: AppIcons._mainColor,
    size: AppSizes.iconButtonM,
  );
  static Widget settingsL({Color color = _mainColor}) {
    return Icon(
      Icons.settings,
      color: color,
      size: AppSizes.iconButtonL,
    );
  }

  static Widget alarmL = const Icon(
    Icons.warning,
    color: AppIcons._mainColor,
    size: AppSizes.iconButtonL,
  );

  static Widget connectedL = const Icon(
    Icons.link,
    color: AppIcons._mainColor,
    size: AppSizes.iconButtonL,
  );

  static Widget disconnectedL = const Icon(
    Icons.link_off,
    color: AppIcons._mainColor,
    size: AppSizes.iconButtonL,
  );
}
