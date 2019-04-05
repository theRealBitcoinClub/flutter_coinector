import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:endlisch/Merchant.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ItemInfoStackLayer extends StatelessWidget {
  const ItemInfoStackLayer({
    Key key,
    @required this.item,
    @required this.textStyle,
    @required this.textStyleSmall,
    @required this.tagText,
  }) : super(key: key);

  final Merchant item;
  final TextStyle textStyle;
  final TextStyle textStyleSmall;
  final Set<String> tagText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Text(item.name + "   ", style: textStyle),
            Row(
              children: <Widget>[
                Text(item.location + "   ", style: textStyleSmall),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  "0,1 km   ",
                  style: textStyleSmall,
                ),
                Stack(
                  children: <Widget>[
                    SmoothStarRating(
                      allowHalfRating: true,
                      starCount: 5,
                      rating: double.parse(item.reviewStars),
                      size: 15.0,
                      color: Colors.yellow[700],
                      borderColor: Colors.white,
                    ),
                    Container(
                      child: Text(item.reviewStars, style: textStyleSmall),
                      decoration:
                          BoxDecoration(color: Colors.black.withOpacity(0.5)),
                    )
                  ],
                )
              ],
            ),
            Text(
                parseElementAt(0) +
                    ", " +
                    parseElementAt(1) +
                    ", " +
                    parseElementAt(2) +
                    ", " +
                    parseElementAt(3),
                style: textStyleSmall)
          ],
        ),
      ),
    );
  }

  String parseElementAt(int pos) =>
      tagText.elementAt(int.parse(item.tags.split(",").elementAt(pos)));
}
