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
    @required this.height,
  }) : super(key: key);

  final Merchant item;
  final TextStyle textStyle;
  final TextStyle textStyleSmall;
  final double height;

  @override
  Widget build(BuildContext context) {
    var splittedtags = item.tags.split(",");
    return Container(
      height: height,
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
            SizedBox(
              height: 5,
            ),
            Row(
              children: <Widget>[
                Text(item.location + "   ", style: textStyleSmall),
                item.reviewCount == '0'
                    ? Padding(
                        padding: EdgeInsets.all(0.0),
                      )
                    : Row(
                        children: <Widget>[
                          SmoothStarRating(
                            allowHalfRating: true,
                            starCount: 5,
                            rating: double.parse(item.reviewStars),
                            size: 15.0,
                            color: Colors.yellow[700],
                            borderColor: Colors.white,
                          ),
                          Text(
                              " " + convertRatingToPercentage(item.reviewStars),
                              style: textStyleSmall),
                        ],
                      )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
                parseElementAt(splittedtags, 0) +
                    parseElementAt(splittedtags, 1) +
                    parseElementAt(splittedtags, 2) +
                    parseElementAt(splittedtags, 3),
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.white.withOpacity(0.8)))
          ],
        ),
      ),
    );
  }

  String convertRatingToPercentage(String stars) {
    return (double.parse(stars) * 20).round().toString() + "%";
  }

  String parseElementAt(splittedTags, int pos) {
    int tagIndex = int.parse(splittedTags.elementAt(pos));

    if (tagIndex == 104) return "";

    String addSeparator = "";
    if (pos != 0) addSeparator = " - ";

    return addSeparator + Tags.tagText.elementAt(tagIndex);
  }
}
