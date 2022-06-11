import 'package:Coinector/FileCache.dart';
import 'package:Coinector/TabPageCategory.dart';
import 'package:Coinector/TabPageStatistics.dart';
import 'package:Coinector/TagBrands.dart';
import 'package:Coinector/TagCoins.dart';
import 'package:Coinector/TagContinents.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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

  static const int MINIMUM_TO_APPEAR_IN_STATS = 40;

  initState() {
    super.initState();
    _tabController = TabController(
        vsync: this,
        length: TabPagesStatistics.pages.length,
        animationDuration: const Duration(milliseconds: 900));
    _tabController.addListener(_handleTabSelection);
    counter = Map();
    initTabContinentByContinent(0);
    // _initTab(0);
  }

  void _initCounterCoins(item) {
    List<String> coins = item['w'].toString().split(",");
    coins.forEach((String c) {
      if (counter[c] == null) counter[c] = 0;
      setState(() {
        counter[c]++;
      });
    });
  }

  void _initCounterBrand(item) {
    _initCounter(item, 'b');
  }

  void _initCounter(item, attributeId) {
    String attribute = item[attributeId];
    String key = attribute == "999" ? "6" : attribute;
    if (counter[key] == null) counter[key] = 0;
    setState(() {
      counter[key]++;
    });
  }

  void _initCounterType(item) {
    _initCounter(item, 't');
  }

  void _initCounterContinent(String continent) {
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
                    sectionsSpace: 1,
                    centerSpaceRadius: 65,
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
          isScrollable: false,
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
        pinned: true);
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
    var minimumThreshold = checkForMinimumThreshold(page);
    List<int> passedMinimumShowThese = minimumThreshold[0];
    List<int> passedMinimumFailed = minimumThreshold[1];
    counter["other"] = 0;
    passedMinimumFailed.forEach((element) {
      counter["other"] += getCounter(element.toString()).toInt();
    });
    bool hasOther = counter["other"] != 0;

    return List.generate(passedMinimumShowThese.length + (hasOther ? 1 : 0),
        (i) {
      final isOther = i == passedMinimumShowThese.length ? true : false;
      if (isOther) return pieChartOther();
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 16.0 : 14.0;
      final radius = isTouched ? 115.0 : 100.0;
      final widgetSize = isTouched ? 75.0 : 60.0;
      var variety = getVariety(passedMinimumShowThese[i]);
      var c = getCounter(passedMinimumShowThese[i].toString());
      return pieChartVariety(
          variety, c, radius, fontSize, isTouched, widgetSize);
    }, growable: false);
  }

  PieChartSectionData pieChartVariety(variety, double c, double radius,
      double fontSize, bool isTouched, double widgetSize) {
    Color color = variety.color;
    if (!kReleaseMode)
      print("\n" +
          variety.long +
          "\n" +
          c.toString() +
          "\n" +
          color.red.toString() +
          "\n" +
          color.green.toString() +
          "\n" +
          color.blue.toString() +
          "\n" +
          "\n");

    return PieChartSectionData(
      titlePositionPercentageOffset: .4,
      color: color,
      value: c,
      title: c.toInt().toString(),
      radius: radius,
      titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w400,
          color: const Color.fromRGBO(255, 255, 255, 1.0)),
      badgeWidget: _Badge(
          (isTouched && variety.icon == null) ? variety.long : variety.short,
          widgetSize,
          color,
          variety.icon,
          isTouched),
      badgePositionPercentageOffset: .98,
    );
  }

  PieChartSectionData pieChartOther() {
    return PieChartSectionData(
        value: counter["other"].toDouble(),
        color: Colors.grey,
        title: "Other",
        radius: 100,
        titlePositionPercentageOffset: .4);
  }

  List<List<int>> checkForMinimumThreshold(TabPageStatistics page) {
    List<int> passedMinimumShowThese = [];
    List<int> passedMinimumFailed = [];
    for (int x = 0; x < page.varietyCount; x++) {
      var counter = getCounter(x.toString());
      if (counter < MINIMUM_TO_APPEAR_IN_STATS) {
        passedMinimumFailed.add(x);
        continue;
      }
      passedMinimumShowThese.add(x);
    }
    List<List<int>> results = [];
    results.add(passedMinimumShowThese);
    results.add(passedMinimumFailed);
    return results;
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
    counter = Map();
    initTabContinentByContinent(_tabController.index);
    /*if (_tabController.index == 3) {
      initTabContinentByContinent(3);
    } else
      _initTab(_tabController.index);*/
  }

  void initTabContinentByContinent(int index) {
    TagContinent.getContinents().forEach((TagContinent element) {
      _initTab(index, element.short.toLowerCase());
    });
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

  void _initTab(int i, String continent) {
    title = TabPagesStatistics.pages[_tabController.index].title;
    FileCache.loadAndDecodeAsset(continent).then((places) {
      places.forEach((item) {
        try {
          switch (i) {
            case 0:
              _initCounterCoins(item);
              break;
            case 1:
              _initCounterBrand(item);
              break;
            case 2:
              _initCounterType(item);
              break;
            case 3:
              _initCounterContinent(continent);
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
  final bool isTouched;

  const _Badge(this.text, this.size, this.color, this.icon, this.isTouched,
      {Key key})
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
        border: isTouched
            ? null
            : Border.all(
                color: Color(0xffffffff),
                width: 1,
              ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.3),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child:
            icon == null ? Text(text) : (isTouched ? Text(text) : Icon(icon)),
      ),
    );
  }
}
