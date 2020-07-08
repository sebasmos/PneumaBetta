import 'dart:convert'; // @TODO: improve

import 'package:flutter/material.dart';

import './BackgroundCollectingTask.dart';

import 'package:bezier_chart/bezier_chart.dart';

class BackgroundCollectedVisor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BackgroundCollectingTask task =
        BackgroundCollectingTask.of(context, rebuildOnChange: true);

    // Arguments shift is needed for timestamps as miliseconds in double could loose precision.
    final int argumentsShift =
        task.samples.first.timestamp.millisecondsSinceEpoch;

    final Duration showDuration =
        Duration(hours: 2); // @TODO . show duration should be configurable
    final Iterable<DataSample> lastSamples = task.getLastOf(showDuration);

//    final Iterable<double> arguments = lastSamples.map((sample) {
//      return (sample.timestamp.millisecondsSinceEpoch - argumentsShift)
//          .toDouble();
//    });

    // Step for argument labels
    final Duration argumentsStep =
        Duration(minutes: 15); // @TODO . step duration should be configurable

    // Find first timestamp floored to step before
    final DateTime beginningArguments = lastSamples.first.timestamp;
    DateTime beginningArgumentsStep = DateTime(beginningArguments.year,
        beginningArguments.month, beginningArguments.day);
    while (beginningArgumentsStep.isBefore(beginningArguments)) {
      beginningArgumentsStep = beginningArgumentsStep.add(argumentsStep);
    }
    beginningArgumentsStep = beginningArgumentsStep.subtract(argumentsStep);
    final DateTime endingArguments = lastSamples.last.timestamp;

    // Generate list of timestamps of labels
//    final Iterable<DateTime> argumentsLabelsTimestamps = () sync* {
//      DateTime timestamp = beginningArgumentsStep;
//      yield timestamp;
//      while (timestamp.isBefore(endingArguments)) {
//        timestamp = timestamp.add(argumentsStep);
//        yield timestamp;
//      }
//    }();

    // Map strings for labels
//    final Iterable<LabelEntry> argumentsLabels =
//        argumentsLabelsTimestamps.map((imestamp) {
//      return LabelEntry(
//          (timestamp.millisecondsSinceEpoch - argumentsShift).toDouble(),
//          ((timestamp.hour <= 9 ? '0' : '') +
//              timestamp.hour.toString() +
//              ':' +
//              (timestamp.minute <= 9 ? '0' : '') +
//              timestamp.minute.toString()));
//    });

    /* TODO: implement */
//    List<Widget> _buildComp() {
//      try {
//        return <Widget>[
//          ListTile(
//            leading: const Icon(Icons.brightness_7),
//            title: const Text('Temperatures'),
//            subtitle: const Text('In Celsius'),
//          ),
//        ];
//      } on Exception catch (_) {
//        return [Text("hi")];
//      }
//    }

    List<DataPoint<dynamic>> data = lastSamples.toList().asMap()
        .map((i, element) => MapEntry(i, DataPoint<double>(
        value: jsonDecode(element.jsonMessage)['pressure'].toDouble(),
        xAxis: i.toDouble()))).values
        .toList();

    return Container(
      color: Colors.transparent,
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width * 0.9,
      child: BezierChart(
        bezierChartScale: BezierChartScale.CUSTOM,
        xAxisCustomValues: data.map((s)=>(s.xAxis as num) as double).toList(), //Timestamp
        series: [
          BezierLine(
              data: data
          )
        ],
        config: BezierChartConfig(
          verticalIndicatorStrokeWidth: 3.0,
          verticalIndicatorColor: Colors.black26,
          showVerticalIndicator: true,
          backgroundColor: Colors.transparent,
          snap: false,
        ),
      ),
    );
  }
}
