import 'package:flutter/material.dart';
import 'package:simple_graph_viewer/src/constants/constants.dart';

/// Creates the big displays for the Ppeak, peep, and such
/// Does not updates it's own state
/// Has some math for the colors
class HeadingIndicator extends StatelessWidget {
  final String title;
  final double value;
  final String? units;
  final double? maxValue;
  final double? minValue;
  final Color? color;

  // Alert color only when over min or max
  // Warning color when in 10% of max/min value
  //ignore: non_constant_identifier_names
  final PERCENTAGE_FOR_WARNING_COLOR = 0.1;

  const HeadingIndicator({
    super.key,
    required this.title,
    required this.value,
    this.units,
    this.maxValue,
    this.minValue,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    var textColor = _getColor();
    return Container(
      constraints: const BoxConstraints(maxWidth: 330),
      decoration: BoxDecoration(
        color: AppColors.lightBlack,
        borderRadius: AppSizes.borderRadiusS,
      ),
      height: 140,
      width: double.infinity,
      child: Padding(
        padding: AppSizes.elementPaddingM,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: AppTextStyles.h5,
                ),
                Text(
                  value.toStringAsFixed(1),
                  style: AppTextStyles.p.copyWith(
                    fontSize: 50,
                    color: textColor,
                  ),
                ),
              ],
            ),
            if (maxValue != null || minValue != null || units != null)
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (units != null) Text(units!) else const SizedBox(),
                  if (maxValue != null || minValue != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (maxValue != null)
                          Text(
                            maxValue!.toStringAsFixed(0),
                            style: AppTextStyles.p.copyWith(color: textColor),
                          ),
                        if (minValue != null)
                          Text(
                            minValue!.toStringAsFixed(0),
                            style: AppTextStyles.p.copyWith(color: textColor),
                          ),
                      ],
                    )
                ],
              ),
          ],
        ),
      ),
    );
  }

  Color _getColor() {
    var selectedColor = AppColors.successGreen;
    if (color != null) {
      selectedColor = color!;
    }
    if (maxValue != null) {
      if (value > maxValue!) {
        selectedColor = AppColors.errorRed;
      } else if ((value - maxValue!).abs() <=
          maxValue! * PERCENTAGE_FOR_WARNING_COLOR) {
        selectedColor = AppColors.warningYellow;
      }
    }
    if (minValue != null) {
      if (value < minValue!) {
        selectedColor = AppColors.errorRed;
      } else if ((value - minValue!).abs() <=
          minValue! * PERCENTAGE_FOR_WARNING_COLOR) {
        selectedColor = AppColors.warningYellow;
      }
    }
    return selectedColor;
  }
}
