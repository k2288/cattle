import 'package:flutter/material.dart';

/// Simple placeholder replacing the removed charts_flutter based chart.
class MilkChart extends StatelessWidget {
  final List<dynamic> seriesList;
  final bool animate;

  const MilkChart(this.seriesList, {super.key, this.animate = false});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
