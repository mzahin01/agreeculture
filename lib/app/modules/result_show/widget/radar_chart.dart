import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RadarChartWidget extends StatelessWidget {
  final String dataString;
  final String title;
  final Color graphColor;

  const RadarChartWidget({
    super.key,
    required this.dataString,
    required this.title,
    this.graphColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    // Parse each character in the string to int
    List<int> values = dataString.split('').map((e) => int.parse(e)).toList();

    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        AspectRatio(
          aspectRatio: 1.3,
          child: RadarChart(
            RadarChartData(
              radarTouchData: RadarTouchData(enabled: true),
              isMinValueAtCenter: false,
              dataSets: [
                RadarDataSet(
                  fillColor: graphColor.withOpacity(0.2),
                  borderColor: graphColor,
                  borderWidth: 2,
                  entryRadius: 5,
                  dataEntries: List.generate(values.length, (index) {
                    return RadarEntry(value: values[index].toDouble());
                  }),
                ),
                RadarDataSet(
                  fillColor: Colors.transparent,
                  borderColor: Colors.transparent,
                  borderWidth: 0,
                  entryRadius: 0,
                  dataEntries: List.generate(values.length, (index) {
                    return RadarEntry(value: index == 0 ? 0 : 4);
                  }),
                ),
              ],
              radarBorderData: const BorderSide(color: Colors.transparent),
              titlePositionPercentageOffset: 0.2,
              titleTextStyle: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
              getTitle:
                  (index, angle) => RadarChartTitle(text: 'Q${index + 1}'),
              tickCount: 4,
              ticksTextStyle: const TextStyle(
                color: Colors.black54,
                fontSize: 10,
              ),
              gridBorderData: const BorderSide(color: Colors.black26, width: 1),
              radarShape: RadarShape.polygon,
            ),
          ),
        ),
      ],
    );
  }
}
