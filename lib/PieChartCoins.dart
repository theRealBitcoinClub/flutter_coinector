import 'package:Coinector/TagCoins.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'AssetLoader.dart';

/// Icons by svgrepo.com (https://www.svgrepo.com/collection/job-and-professions-3/)
class PieChartCoins extends StatefulWidget {
  const PieChartCoins({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChartCoinsState();
}

class PieChartCoinsState extends State {
  int touchedIndex = 0;
  Map<int, int> counter = Map();

  initState() {
    super.initState();
    AssetLoader.loadAndDecodeAsset("assets/places.json").then((places) {
      places.forEach((item) {
        try {
          List<String> coins = item['w'].toString().split(",");
          coins.forEach((String c) {
            int coin = int.parse(c);
            if (counter[coin] == null) counter[coin] = 0;
            setState(() {
              counter[coin]++;
            });
          });
        } catch (e) {}
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: Colors.black12,
        child: AspectRatio(
          aspectRatio: 1,
          child: PieChart(
            PieChartData(
                pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection.touchedSectionIndex;
                  });
                }),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 0,
                sections: showingSections()),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 16.0 : 14.0;
      final radius = isTouched ? 200.0 : 175.0;
      final widgetSize = isTouched ? 55.0 : 40.0;
      var coin = TagCoin.getTagCoins().elementAt(i);
      return PieChartSectionData(
        color: coin.color,
        value: getCounter(i),
        title: coin.short,
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w400,
            color: const Color.fromRGBO(255, 255, 255, 1.0)),
        badgeWidget: _Badge(
          coin.short,
          size: widgetSize,
          color: coin.color,
        ),
        badgePositionPercentageOffset: .98,
      );
    });
  }

  double getCounter(int index) =>
      counter[index] != null ? counter[index].toDouble() : 0.0;
}

class _Badge extends StatelessWidget {
  final String text;
  final double size;
  final Color color;

  const _Badge(
    this.text, {
    Key key,
    this.size,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: Color(0xffffffff),
          width: 1,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: Text(text),
      ),
    );
  }
}
