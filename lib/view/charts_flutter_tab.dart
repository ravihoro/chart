import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../model/performance_model.dart';

class ChartsFlutterTab extends StatelessWidget {
  final List<PerformanceModel> dataList;

  ChartsFlutterTab({this.dataList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                'Result Time (Minutes:Seconds.MilliSec',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: 2,
            ),
            Flexible(
              child: Container(
                height: 500,
                child: charts.TimeSeriesChart(
                  [
                    charts.Series<PerformanceModel, DateTime>(
                      id: 'performance',
                      colorFn: (_, __) =>
                          charts.MaterialPalette.red.shadeDefault,
                      domainFn: (PerformanceModel model, _) => model.date,
                      measureFn: (PerformanceModel model, _) =>
                          model.performance.inSeconds,
                      data: dataList,
                    ),
                  ],
                  defaultRenderer: charts.LineRendererConfig(
                    includePoints: true,
                  ),
                  primaryMeasureAxis: charts.NumericAxisSpec(
                    viewport: charts.NumericExtents(130, 180),
                    // tickProviderSpec:
                    //     charts.BasicNumericTickProviderSpec(
                    //   desiredTickCount: 10000,
                    // ),
                    tickFormatterSpec:
                        charts.BasicNumericTickFormatterSpec((val) {
                      double seconds = val % 60;
                      int minutes = val ~/ 60;
                      if (seconds == 0.0) return '$minutes:00.00';
                      return '$minutes:${seconds.toStringAsFixed(0)}.00';
                    }),
                  ),
                  flipVerticalAxis: true,
                  domainAxis: charts.DateTimeAxisSpec(
                    renderSpec: charts.GridlineRendererSpec(),
                    viewport: charts.DateTimeExtents(
                      end: DateTime(2018, 9),
                      start: DateTime(2015),
                    ),
                    tickProviderSpec:
                        charts.DayTickProviderSpec(increments: [180]),
                    tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
                      year: charts.TimeFormatterSpec(
                          transitionFormat: ' MMM yyyy'),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Competition Date',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
