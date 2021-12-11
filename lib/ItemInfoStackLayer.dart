import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';

import 'Merchant.dart';
import 'TagParser.dart';

class TagFilterCallback {
  doFilter(String search) {}
}

class ItemInfoStackLayer extends StatelessWidget {
  const ItemInfoStackLayer({
    Key key,
    @required this.filterCallback,
    @required this.merchant,
    @required this.textStyleMerchantTitle,
    @required this.textStyleMerchantLocation,
    @required this.height,
  }) : super(key: key);

  final TagFilterCallback filterCallback;
  final Merchant merchant;
  final TextStyle textStyleMerchantTitle;
  final TextStyle textStyleMerchantLocation;
  final double height;

  @override
  Widget build(BuildContext context) {
    var splittedTags = merchant.tags.split(",");
    return Container(
      height: height,
      child: ListView(
        padding: EdgeInsets.fromLTRB(kIsWeb ? 10.0 : 8.0, kIsWeb ? 5.0 : 3.0, 10.0, 0.0),
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                merchant.name,
                style: textStyleMerchantTitle,
                maxLines: 1,
              )),
          const SizedBox(
            height: 3,
          ),
          SingleChildScrollView(padding: EdgeInsets.all(0.0),
              scrollDirection: Axis.horizontal,
              child: Text(
                merchant.location,
                maxLines: 1,
                style: textStyleMerchantLocation,
              )),
          const SizedBox(
            height: kIsWeb ? 4 : 0.01,
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: buildTagTextItems(context, splittedTags))),
        ],
      ),
    );
  }

  List<Widget> buildTagTextItems(ctx, List<String> splittedTags) {
    return splittedTags.map((title) {
      return Padding(
          padding: EdgeInsets.only(left: 5.0, right: 5.0),
          child: HoverButton(
              padding: EdgeInsets.all(0.0),
              hoverPadding: EdgeInsets.all(0.0),
              onpressed: () => restartWidgetWithFilter(ctx, title),
              child: Text(TagParser.parseTag(title),
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      textBaseline: TextBaseline.alphabetic,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.white))));
    }).toList();
  }

  void restartWidgetWithFilter(ctx, String title) {
    filterCallback.doFilter(TagParser.parseTag(title));
  }
}
