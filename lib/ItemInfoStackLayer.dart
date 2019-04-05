import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:endlisch/Merchant.dart';

class ItemInfoStackLayer extends StatelessWidget {
  const ItemInfoStackLayer({
    Key key,
    @required this.item,
    @required this.textStyle,
    @required this.textStyle2,
    @required this.tagText,
  }) : super(key: key);

  final Merchant item;
  final TextStyle textStyle;
  final TextStyle textStyle2;
  final Set<String> tagText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Text(item.name, style: textStyle),
            Text(item.location, style: textStyle2),
            Text(
                "Distance: 0,1km, Reviews: " +
                    item.reviewStars +
                    " (" +
                    item.reviewCount +
                    ")",
                style: textStyle2),
            Text(
                parseElementAt(0) +
                    ", " +
                    parseElementAt(1) +
                    ", " +
                    parseElementAt(2) +
                    ", " +
                    parseElementAt(3),
                style: textStyle2)
          ],
        ),
      ),
    );
  }
  
  String parseElementAt(int pos) =>
      tagText.elementAt(int.parse(item.tags.split(",").elementAt(pos)));
}