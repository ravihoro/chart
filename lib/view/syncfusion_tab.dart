import 'package:flutter/material.dart';
import '../model/performance_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class SyncFusionTab extends StatelessWidget {
  final List<PerformanceModel> dataList;

  SyncFusionTab({this.dataList});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Container(
            height: 500,
            child: SfCartesianChart(
              title: ChartTitle(
                text:
                    'Performance Progression over Time for Utkarsh Santosh Patil',
              ),
              legend: Legend(
                isVisible: true,
              ),
              primaryXAxis: DateTimeAxis(
                interval: 6,
                dateFormat: DateFormat('MMM yyyy'),
                title: AxisTitle(
                  text: 'Competition Date',
                ),
              ),
              axisLabelFormatter: (AxisLabelRenderDetails args) {
                if (args.axisName == 'primaryYAxis') {
                  String text;
                  TextStyle textStyle = args.textStyle.copyWith();
                  double seconds = double.parse(args.text) % 60;
                  int minutes = double.parse(args.text) ~/ 60;

                  text = '$minutes:${seconds.toStringAsFixed(0)}.00';
                  return ChartAxisLabel(text, textStyle);
                } else {
                  return ChartAxisLabel(args.text, args.textStyle);
                }
              },
              primaryYAxis: NumericAxis(
                isInversed: true,
                interval: 2,
                labelFormat: '{value}',
                title:
                    AxisTitle(text: 'Result Time (Minutes:Seconds.MilliSec)'),
              ),
              series: <ChartSeries>[
                LineSeries<PerformanceModel, DateTime>(
                  name: 'Result Time',
                  dataSource: dataList,
                  xValueMapper: (PerformanceModel model, _) => model.date,
                  yValueMapper: (PerformanceModel model, _) =>
                      model.performance.inSeconds,
                  markerSettings: MarkerSettings(
                    isVisible: true,
                    shape: DataMarkerType.invertedTriangle,
                    color: Colors.red,
                  ),
                  color: Colors.red,
                  sortingOrder: SortingOrder.ascending,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
