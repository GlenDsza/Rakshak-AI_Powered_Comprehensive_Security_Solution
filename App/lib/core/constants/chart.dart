import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartConstants {
  BarChartConstants(
      int showingTooltip, List<BarData> dataList, List<String> weekDays) {
    this.showingTooltip = showingTooltip;
    this.dataList = dataList;
    this.weekDays = weekDays;
  }

  static final shadowColor = const Color(0xFFCCCCCC);
  int showingTooltip = -1;
  List<BarData> dataList = [];
  List<String> weekDays = [];

  BarChartGroupData generateBarGroup(
    int x,
    Color color,
    double value,
    double shadowValue,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: 6,
        ),
        BarChartRodData(
          toY: shadowValue,
          color: shadowColor,
          width: 6,
        ),
      ],
      showingTooltipIndicators: showingTooltip == x ? [0] : [],
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      // fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text(weekDays[0], style: style);
        break;
      case 1:
        text = Text(weekDays[1], style: style);
        break;
      case 2:
        text = Text(weekDays[2], style: style);
        break;
      case 3:
        text = Text(weekDays[3], style: style);
        break;
      case 4:
        text = Text(weekDays[4], style: style);
        break;
      case 5:
        text = Text(weekDays[5], style: style);
        break;
      case 6:
        text = Text(weekDays[6], style: style);
        break;
      default:
        text = Text(weekDays[6], style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }
}

class BarData {
  const BarData(this.color, this.value, this.shadowValue);
  final Color color;
  final double value;
  final double shadowValue;
}
