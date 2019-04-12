import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:endlisch/Merchant.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:endlisch/Tags.dart';

class ItemInfoStackLayer extends StatelessWidget {
  const ItemInfoStackLayer({
    Key key,
    @required this.item,
    @required this.textStyle,
    @required this.textStyleSmall,
  }) : super(key: key);

  final Merchant item;
  final TextStyle textStyle;
  final TextStyle textStyleSmall;

  @override
  Widget build(BuildContext context) {
    var splittedtags = item.tags.split(",");
    return Container(
      height: 100,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            Text(
              item.name + "   ",
              style: textStyle,
              maxLines: 1,
            ),
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
                parseElementAt(splittedtags, 0) +
                    parseElementAt(splittedtags, 1) +
                    parseElementAt(splittedtags, 2) +
                    parseElementAt(splittedtags, 3),
                style: textStyleSmall)
          ],
        ),
      ),
    );
  }

  String parseElementAt(splittedTags, int pos) {
    int tagIndex = int.parse(splittedTags.elementAt(pos));

    if (tagIndex == 104)
      return "";

    String addSeparator = "";
    if (pos != 0) addSeparator = " - ";

    return addSeparator + Tags.tagText.elementAt(tagIndex);
  }
}
