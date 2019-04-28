import 'package:endlisch/Merchant.dart';
import 'package:endlisch/Tags.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            Text(
              item.name + "   ",
              style: textStyle,
              maxLines: 1,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(item.location + "   ", style: textStyleSmall),
            const SizedBox(
              height: 10,
            ),
            Row(
              //TODO make items fit on the card
              children: <Widget>[
                buildTagText(splittedtags)
              ],
            ),
          ],
        ),
      ),
    );
  }
  Text buildTagText(List<String> splittedtags) {
    return Text(
        parseElementAt(splittedtags, 0) +
            parseElementAt(splittedtags, 1) +
            parseElementAt(splittedtags, 2) +
            parseElementAt(splittedtags, 3) +
            "   ",
        style: TextStyle(
            fontWeight: FontWeight.w300, color: Colors.white.withOpacity(0.8)));
  }


  String parseElementAt(splittedTags, int pos) {
    int tagIndex = int.parse(splittedTags.elementAt(pos));

    if (tagIndex == 104) return "";

    String addSeparator = "";
    if (pos != 0) addSeparator = " - ";

    return addSeparator + Tags.tagText.elementAt(tagIndex);
  }
}
