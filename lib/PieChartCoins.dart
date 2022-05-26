import 'package:Coinector/TabPageCategory.dart';
import 'package:Coinector/TabPageStatistics.dart';
import 'package:Coinector/TagBrands.dart';
import 'package:Coinector/TagCoins.dart';
import 'package:Coinector/TagContinents.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'AssetLoader.dart';

class PieChartCoins extends StatefulWidget {
  const PieChartCoins({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChartCoinsState();
}

class PieChartCoinsState extends State with TickerProviderStateMixin {
  int touchedIndex = 0;
  Map<String, int> counter = Map();
  TabController _tabController;

  String title;

  int MINIMUM_TO_APPEAR_IN_STATS = 40;

  initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, length: TabPagesStatistics.pages.length);
    _tabController.addListener(_handleTabSelection);
    counter.clear();
    _initTab(0);
  }

  void _initTabCoins(item) {
    List<String> coins = item['w'].toString().split(",");
    coins.forEach((String c) {
      if (counter[c] == null) counter[c] = 0;
      setState(() {
        counter[c]++;
      });
    });
  }

  void _initTabBrand(item) {
    _initCounter(item, 'b');
  }

  void _initCounter(item, attributeId) {
    String brand = item[attributeId];
    if (counter[brand] == null) counter[brand] = 0;
    setState(() {
      counter[brand]++;
    });
  }

  void _initTabType(item) {
    _initCounter(item, 't');
  }

  void _initTabContinent(String continent) {
    if (counter[continent] == null) counter[continent] = 0;
    setState(() {
      counter[continent]++;
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
          color: Colors.lightBlueAccent,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicator: const UnderlineTabIndicator(),
          tabs: TabPagesStatistics.pages.map<Tab>((TabPageStatistics page) {
            return _buildTab(page);
          }).toList(),
        ),
        actions: <Widget>[buildIconButtonClose()],
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
        floating: true,
        snap: true,
        pinned: false);
  }

  Widget buildIconButtonClose() {
    return IconButton(
        tooltip: "Close",
        icon: Icon(Icons.close),
        color: Colors.lightBlueAccent,
        onPressed: () {
          Navigator.pop(context);
        });
  }

  List<PieChartSectionData> showingSections() {
    var page = TabPagesStatistics.pages[_tabController.index];
    List<int> passedMinimumShowThese = checkForMinimumThreshold(page);
    return List.generate(passedMinimumShowThese.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 16.0 : 14.0;
      final radius = isTouched ? 200.0 : 175.0;
      final widgetSize = isTouched ? 75.0 : 60.0;
      var variety = getVariety(passedMinimumShowThese[i]);
      var counter = getCounter(passedMinimumShowThese[i].toString());
      return PieChartSectionData(
        color: variety.color,
        value: counter,
        title: counter.toInt().toString(),
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w400,
            color: const Color.fromRGBO(255, 255, 255, 1.0)),
        badgeWidget: _Badge(isTouched ? variety.long : variety.short,
            widgetSize, variety.color, variety.icon),
        badgePositionPercentageOffset: .98,
      );
    }, growable: false);
  }

  List<int> checkForMinimumThreshold(TabPageStatistics page) {
    List<int> passedMinimumShowThese = [];
    for (int x = 0; x < page.varietyCount; x++) {
      var counter = getCounter(x.toString());
      if (counter < MINIMUM_TO_APPEAR_IN_STATS) {
        continue;
      }
      passedMinimumShowThese.add(x);
    }
    return passedMinimumShowThese;
  }

  getVariety(int i) {
    var variety;
    switch (_tabController.index) {
      case 0:
        variety = TagCoin.getTagCoins().elementAt(i);
        break;
      case 1:
        variety = TagBrand.getBrands().elementAt(i);
        break;
      case 2:
        variety = TabPages.pages.elementAt(i);
        break;
      case 3:
        variety = TagContinent.getContinents().elementAt(i);
        break;
    }
    return variety;
  }

  double getCounter(String index) {
    if (_tabController.index == 3)
      index = TagContinent.getContinents()
          .elementAt(int.parse(index))
          .short
          .toLowerCase();

    return counter[index] != null ? counter[index].toDouble() : 0.0;
  }

  var _lastTab;

  void _handleTabSelection() {
    if (_lastTab != null && _lastTab == _tabController.index) return;

    _lastTab = _tabController.index;
    counter.clear();
    if (_tabController.index == 3) {
      TagContinent.getContinents().forEach((TagContinent element) {
        _initTab(3, continent: element.short.toLowerCase());
      });
    } else
      _initTab(_tabController.index);
  }

  Tab _buildTab(TabPageStatistics page) {
    return Tab(
        text: page.text,
        icon: Icon(
          page.icon,
          color: page.color,
          size: 22,
        ));
  }

  void _initTab(int i, {String continent}) {
    title = TabPagesStatistics.pages[_tabController.index].title;
    AssetLoader.loadAndDecodeAsset(
            "assets/" + (continent != null ? continent : "places") + ".json")
        .then((places) {
      String bla = "";
      places.forEach((item) {
        try {
          switch (i) {
            case 0:
              _initTabCoins(item);
              break;
            case 1:
              _initTabBrand(item);
              break;
            case 2:
              _initTabType(item);
              break;
            case 3:
              _initTabContinent(continent);
              break;
          }
        } catch (e) {}
      });
    });
  }
}

class _Badge extends StatelessWidget {
  final String text;
  final IconData icon;
  final double size;
  final Color color;

  const _Badge(this.text, this.size, this.color, this.icon, {Key key})
      : super(key: key);

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
        child: icon == null ? Text(text) : Icon(icon),
      ),
    );
  }
}
