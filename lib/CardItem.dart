import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Merchant.dart';

/// Displays its integer item as 'item N' on a Card whose color is based on
/// the item's value. The text is displayed in bright green if selected is true.
/// This widget's height is based on the animation parameter, it varies
/// from 0 to 128 as the animation varies from 0.0 to 1.0.
class CardItem extends StatelessWidget {
  const CardItem(
      {Key key,
      @required this.animation,
      this.onTap,
      @required this.item,
      this.selected: false})
      : assert(animation != null),
        assert(item != null),
        assert(selected != null),
        super(key: key);

  final Animation<double> animation;
  final VoidCallback onTap;
  final Merchant item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    //Merchant m2 = Merchant.fromJson(jsonDecode(item.toString()));
    TextStyle textStyle = Theme.of(context).textTheme.body1;
    TextStyle textStyle2 = Theme.of(context).textTheme.body2;
    //if (selected)
    //textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: SizeTransition(
        axis: Axis.vertical,
        sizeFactor: animation,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: SizedBox(
            height: 402,
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Card(
                  color: Colors.primaries[item.type % 17],
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Image.network(
                            "https://realbitcoinclub.firebaseapp.com/img/app/" +
                                item.id +
                                ".gif",
                            height: 320,
                            alignment: Alignment.topCenter,
                          ),
                          Container(
                            height: 90,
                            decoration: BoxDecoration(
                              color: Colors.primaries[item.type % 17].withOpacity(0.8),
                              //gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.black, Colors.white]),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: ListView(
                                children: <Widget>[
                                  Text(item.name, style: textStyle),
                                  Text(item.tags, style: textStyle2),
                                  Text(
                                      "Reviews: " +
                                          item.reviewStars +
                                          " (" +
                                          item.reviewCount +
                                          ")",
                                      style: textStyle2),
                                  Text(item.location, style: textStyle2)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      ButtonTheme.bar(
                        // make buttons use the appropriate styles for cards
                        child: ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text('DIRECTIONS'),
                              onPressed: () {/* ... */},
                            ),
                            FlatButton(
                              child: const Text('EXPAND'),
                              onPressed: () {/* ... */},
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
