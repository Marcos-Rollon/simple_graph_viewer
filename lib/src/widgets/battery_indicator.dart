import 'package:flutter/material.dart';
import './blink_widget.dart';
import '../constants/constants.dart';

enum BatteryIndicatorState {
  acFull,
  acChargin,
  high,
  medium,
  low,
}

class BatteryIndicator extends StatelessWidget {
  final BatteryIndicatorState state;
  final double iconSize;

  const BatteryIndicator({
    super.key,
    required this.state,
    this.iconSize = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 80),
      padding: AppSizes.elementPaddingM,
      decoration: BoxDecoration(
        color: AppColors.lightBlack,
        borderRadius: AppSizes.borderRadiusS,
      ),
      child: _getChild(),
    );
  }

  Widget _generateWidget(IconData first, Color firstColor, IconData second) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          first,
          size: iconSize,
          color: firstColor,
        ),
        AppSizes.horizontalSpacerS,
        (state == BatteryIndicatorState.acChargin ||
                state == BatteryIndicatorState.acFull)
            ? Icon(
                second,
                size: iconSize,
                color: AppColors.white,
              )
            : BlinkWidget(
                children: [
                  Icon(
                    second,
                    size: iconSize,
                    color: AppColors.white,
                  ),
                  const SizedBox()
                ],
              )
      ],
    );
  }

  Widget _getChild() {
    switch (state) {
      case BatteryIndicatorState.acFull:
        return _generateWidget(
          Icons.battery_charging_full_rounded,
          AppColors.successGreen,
          Icons.power,
        );
      case BatteryIndicatorState.acChargin:
        return _generateWidget(
          Icons.battery_3_bar_rounded,
          AppColors.successGreen,
          Icons.power,
        );
      case BatteryIndicatorState.high:
        return _generateWidget(
          Icons.battery_5_bar_rounded,
          AppColors.successGreen,
          Icons.power_off,
        );
      case BatteryIndicatorState.medium:
        return _generateWidget(
          Icons.battery_3_bar_rounded,
          AppColors.warningYellow,
          Icons.power_off,
        );
      case BatteryIndicatorState.low:
        return _generateWidget(
          Icons.battery_1_bar_rounded,
          AppColors.errorRed,
          Icons.power_off,
        );
    }
  }
}
