import 'package:coinector/Merchant.dart';
import 'package:coinector/TagParser.dart';
import 'package:coinector/Tags.dart';
import 'package:coinector/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ItemInfoStackLayer extends StatelessWidget {
  const ItemInfoStackLayer({
    Key key,
    @required this.merchant,
    @required this.textStyleMerchantTitle,
    @required this.textStyleMerchantLocation,
    @required this.height,
  }) : super(key: key);

  final Merchant merchant;
  final TextStyle textStyleMerchantTitle;
  final TextStyle textStyleMerchantLocation;
  final double height;

  @override
  Widget build(BuildContext context) {
    var splittedtags = merchant.tags.split(",");
    return Container(
      //decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
      height: height,
      child: Padding(
        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            Text(
              merchant.name,
              style: textStyleMerchantTitle,
              maxLines: 1,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              merchant.location,
              maxLines: 1,
              style: textStyleMerchantLocation,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[buildTagText(splittedtags)],
            ),
          ],
        ),
      ),
    );
  }

  Text buildTagText(List<String> splittedtags) {
    return Text(TagParser.parseTagIndexToText(splittedtags),
        style: TextStyle(
            fontSize: 15.0, fontWeight: FontWeight.w300, color: Colors.white));
  }
}
