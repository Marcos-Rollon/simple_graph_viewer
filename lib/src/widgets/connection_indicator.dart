import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'blink_widget.dart';

class ConnectionIndicator extends StatelessWidget {
  final bool connected;
  final double iconSize;

  const ConnectionIndicator({
    super.key,
    required this.connected,
    this.iconSize = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 160,
        minHeight: iconSize + AppSizes.elementPaddingM.vertical,
      ),
      padding: AppSizes.elementPaddingM,
      decoration: BoxDecoration(
        color: AppColors.lightBlack,
        borderRadius: AppSizes.borderRadiusS,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          connected
              ? Icon(
                  Icons.link,
                  color: AppColors.successGreen,
                  size: iconSize,
                )
              : BlinkWidget(
                  children: [
                    Icon(
                      Icons.link_off,
                      color: AppColors.errorRed,
                      size: iconSize,
                    ),
                    SizedBox(width: iconSize)
                  ],
                ),
          AppSizes.horizontalSpacerM,
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              connected ? "CONNECTED" : "DISCONNECTED",
              style: !connected
                  ? const TextStyle().copyWith(color: AppColors.errorRed)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
