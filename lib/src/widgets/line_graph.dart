import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart'; // THIS CLASS DEPENDS OF THE CONSTANTS THAT I PUT IN EVERY PROJECT

/// This is the controller class for the line graph. Every modification should be
/// done using this and not with the ui component directly
class LineGraphController {
  final double sizeX;
  final double maxY;
  final double minY;
  final double minimumColorOpacity;
  final Color color;
  final Color titleColor;
  final Color badgeColor;
  final Color maxLineColor;
  final Color minLineColor;
  final Size size;
  final String title;
  final bool showBellowGradient;
  final bool showMin;
  final bool showMax;

  List<FlSpot> points = [];
  void Function(double value)? _addCallback;
  void Function()? _clearCallback;

  LineGraphController({
    this.title = "",
    this.sizeX = 500,
    this.size = const Size(1000, 400),
    this.color = Colors.redAccent,
    this.titleColor = Colors.white,
    this.badgeColor = Colors.white24,
    this.minimumColorOpacity = 0.3,
    this.showBellowGradient = true,
    this.maxY = 50,
    this.minY = 0,
    this.showMax = true,
    this.showMin = true,
    this.maxLineColor = AppColors.enfasis,
    this.minLineColor = AppColors.white,
  });

  // This function is boilerplate to access the function on the statefull widget
  void setAddPointCallback(void Function(double value) callback) {
    _addCallback = callback;
  }

  // This function is boilerplate to access the function on the statefull widget
  void setClearCallback(void Function() callback) {
    _clearCallback = callback;
  }

  void addPoint(double value) {
    _addCallback?.call(value);
  }

  void clear() {
    _clearCallback?.call();
  }
}

/// This is the UI component of the graph. It uses the controller properties
/// to render whatever it needs to render
class LineGraph extends StatefulWidget {
  final LineGraphController controller;
  final double reservedLeftTitleSize = 40.0;

  const LineGraph({
    super.key,
    required this.controller,
  });

  @override
  State<LineGraph> createState() => _LineGraphState();
}

class _LineGraphState extends State<LineGraph> {
  LineChartBarData barData = LineChartBarData();
  double maxY = 0;
  double minY = 0;

  @override
  void initState() {
    super.initState();
    // This is boilerplate to join the controller callback with the widget
    widget.controller.setAddPointCallback(_addPoints);
    widget.controller.setClearCallback(_clear);
    final color = widget.controller.color;
    final data = _createBarData(color);
    barData = data;
  }

  @override
  Widget build(BuildContext context) {
    double minX = 0;
    if (widget.controller.points.isNotEmpty) {
      minX = widget.controller.points.first.x;
    }

    // Defines the axis position and aspect
    final titlesData = FlTitlesData(
      rightTitles: AxisTitles(
          sideTitles: SideTitles(
        showTitles: true,
        interval: widget.controller.maxY / 10,
        reservedSize: widget.reservedLeftTitleSize,
        getTitlesWidget: _getTilesWidget,
      )),
      bottomTitles: AxisTitles(
          sideTitles: SideTitles(
        showTitles: true,
        interval: widget.controller.sizeX / 5,
        getTitlesWidget: _getBottomTilesWidget,
      )),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(
          sideTitles: SideTitles(
        showTitles: true,
        interval: widget.controller.maxY / 10,
        reservedSize: widget.reservedLeftTitleSize,
        getTitlesWidget: _getTilesWidget,
      )),
    );

    return SizedBox(
      width: widget.controller.size.width,
      height: widget.controller.size.height,
      child: Stack(
        children: [
          LineChart(
            LineChartData(
              minY: widget.controller.minY,
              maxY: widget.controller.maxY,
              minX: minX,
              lineTouchData:
                  LineTouchData(enabled: false), // Remove touch interactions
              clipData: FlClipData.all(),
              gridData: FlGridData(
                drawVerticalLine: true,
                show: true,
                checkToShowHorizontalLine: _checkToShowHorizontalLine,
                getDrawingHorizontalLine: _getDrawingHorizontalLine,
                horizontalInterval: 1,
              ),
              lineBarsData: [barData],
              titlesData: titlesData,
            ),
            // Remove animations for perfomance
            swapAnimationDuration: Duration.zero,
          ),
          _createBadges()
        ],
      ),
    );
  }

  // HELPERS

  /// Appereance of the horizontal lines
  FlLine _getDrawingHorizontalLine(double value) {
    var color = widget.controller.maxLineColor;
    List<int>? dashArray = [10, 10];
    if (value == 0) {
      color = widget.controller.minLineColor;
      dashArray = null;
    }
    if (value - minY.abs() < 0.5) {
      color = widget.controller.minLineColor;
    }
    return HorizontalLine(
      y: value,
      color: color,
      dashArray: dashArray,
    );
  }

  /// Logic to show the horizontal lines (min, max and 0 axis)
  bool _checkToShowHorizontalLine(double value) {
    if (value == 0) return true;
    if ((value - maxY).abs() < 0.5 && widget.controller.showMax) {
      return true;
    }
    if ((value - minY).abs() < 0.5 && widget.controller.showMin) {
      return true;
    }
    return false;
  }

  /// Creates the badges row on the top
  Widget _createBadges() {
    return Padding(
      padding: AppSizes.elementPaddingM,
      child: Row(
        children: [
          SizedBox(width: widget.reservedLeftTitleSize),
          _createBadgeContainer(widget.controller.title,
              widget.controller.titleColor, widget.controller.color),
          if (widget.controller.showMax) ...[
            const SizedBox(width: AppSizes.elementSeparationM),
            _createBadgeContainer("Max", widget.controller.titleColor,
                widget.controller.maxLineColor,
                isDashed: true)
          ],
          if (widget.controller.showMin) ...[
            const SizedBox(width: AppSizes.elementSeparationM),
            _createBadgeContainer("Min", widget.controller.titleColor,
                widget.controller.minLineColor,
                isDashed: true)
          ]
        ],
      ),
    );
  }

  /// Creates the indivitual badges
  Widget _createBadgeContainer(String text, Color textColor, Color lineColor,
      {bool isDashed = false}) {
    List<Widget> createDashed() {
      return [
        Container(color: lineColor, width: 4, height: 2),
        const SizedBox(width: 2),
        Container(color: lineColor, width: 4, height: 2),
        const SizedBox(width: 2),
        Container(color: lineColor, width: 4, height: 2),
      ];
    }

    return Container(
      constraints: BoxConstraints(
        maxWidth: 140,
        minHeight: AppSizes.elementPaddingM.vertical,
      ),
      padding: AppSizes.elementPaddingM,
      decoration: BoxDecoration(
        color: widget.controller.badgeColor,
        borderRadius: AppSizes.borderRadiusS,
      ),
      child: Row(
        children: [
          if (isDashed)
            ...createDashed()
          else
            Container(color: lineColor, width: 10, height: 2),
          AppSizes.horizontalSpacerS,
          Text(
            text,
            style: AppTextStyles.p.copyWith(
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  /// Defines the aspect of the actual line of the graph
  LineChartBarData _createBarData(Color color) {
    // final gradient = LinearGradient(
    //   colors: [color.withOpacity(widget.controller.minimumColorOpacity), color],
    //   stops: const [0, 1.0],
    // );

    return LineChartBarData(
      spots: [],
      dotData: FlDotData(
        show: false,
      ),
      //gradient: gradient,
      color: color,
      belowBarData: BarAreaData(show: true, color: color.withOpacity(0.2)),
      barWidth: 4,
      isCurved: false,
    );
  }

  /// Defines the aspect of the labels (horizontal and vertical)
  Widget _getTilesWidget(double value, TitleMeta? meta) {
    return Text(
      value.toInt().toString(),
      style: AppTextStyles.p,
    );
  }

  /// Defines the aspect of the bottom labels
  Widget _getBottomTilesWidget(double value, TitleMeta? meta) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Text(
        '${(value - widget.controller.sizeX).toInt()}',
        style: AppTextStyles.p,
      ),
    );
  }

  /// Clears all the points from the graphic
  void _clear() {
    widget.controller.points = [];
    barData = barData.copyWith(spots: widget.controller.points);
    setState(() {});
  }

  /// Does all the logic for adding points, removing unused ones and
  /// updating the state
  void _addPoints(double value) {
    // Check if we are full
    if (widget.controller.points.length > widget.controller.sizeX) {
      // Check if the 1 element was the min or max
      if (widget.controller.points.first.y >= maxY) {
        maxY = double.negativeInfinity;
      }
      if (widget.controller.points.first.y <= minY) {
        minY = double.maxFinite;
      }
      // Delete the 1 element
      widget.controller.points.removeAt(0);
      // Shift every point X one place, and use the same loop to assign the new max and min if needed
      for (var i = 0; i < widget.controller.points.length; i++) {
        var point = widget.controller.points[i];

        point.y > maxY ? maxY = point.y : maxY = maxY;
        point.y < minY ? minY = point.y : minY = minY;

        widget.controller.points[i] = point.copyWith(x: point.x - 1);
      }
      // Add the new point at the end
      widget.controller.points.add(
        FlSpot(widget.controller.points.length.toDouble(), value),
      );
    }
    // If not, just add the point
    else {
      widget.controller.points.add(
        FlSpot(widget.controller.points.length.toDouble(), value),
      );
      // Check if the new Y is the maximum and min
      if (value > maxY) {
        maxY = value;
      }
      if (value < minY) {
        minY = value;
      }
    }
    barData = barData.copyWith(spots: widget.controller.points);
    setState(() {});
  }
}
