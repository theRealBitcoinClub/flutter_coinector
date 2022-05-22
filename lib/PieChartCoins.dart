import 'package:Coinector/TagCoins.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
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
          child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext buildCtx, bool innerBoxIsScrolled) {
                return <Widget>[
                  buildSliverAppBar(buildCtx),
                ];
              },
              body: PieChart(
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
              )),
        ),
      ),
    );
  }

  SliverAppBar buildSliverAppBar(BuildContext buildCtx) {
    return SliverAppBar(
        elevation: 2,
        shape:
            kIsWeb //TODO check if user is on mobile with web, then it shall not have rounded corners like in native app
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                  )
                : null,
        forceElevated: true,
        leading: IconButton(
          icon: Icon(Icons.navigate_before),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        /*
        LET USER NAVIGATE FROM ONE TO THE NEXT CHART
        bottom: TabBar(
          controller: tabController,
          isScrollable: true,
          indicator: getIndicator(),
          tabs: TabPages.pages.map<Tab>((TabPageCategory page) {
            return buildColoredTab(page);
          }).toList(),
        ),*/
        actions: <Widget>[],
        title: Text("Coins"),
        floating: true,
        snap: true,
        pinned: false);
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 16.0 : 14.0;
      final radius = isTouched ? 200.0 : 175.0;
      final widgetSize = isTouched ? 75.0 : 60.0;
      var coin = TagCoin.getTagCoins().elementAt(i);
      return PieChartSectionData(
        color: coin.color,
        value: getCounter(i),
        title: getCounter(i).toInt().toString(),
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
