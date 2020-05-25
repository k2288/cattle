/// Example of a simple line chart.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class MilkChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  MilkChart(this.seriesList, {this.animate});


  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(seriesList, animate: animate);
  }

  
  
}

