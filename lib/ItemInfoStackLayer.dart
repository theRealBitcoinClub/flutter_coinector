import 'package:Coinector/TagCoinector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';

import 'Merchant.dart';

class TagFilterCallback {
  doFilter(String search) {}
}

class ItemInfoStackLayer extends StatelessWidget {
  const ItemInfoStackLayer({
    Key? key,
    required this.filterCallback,
    required this.merchant,
    required this.textStyleMerchantTitle,
    required this.textStyleMerchantLocation,
    required this.height,
    required this.isWebMobile,
  }) : super(key: key);

  final TagFilterCallback filterCallback;
  final Merchant merchant;
  final TextStyle textStyleMerchantTitle;
  final TextStyle textStyleMerchantLocation;
  final double height;
  final bool isWebMobile;

  @override
  Widget build(BuildContext context) {
    var splittedTags = merchant.tagsDatabaseFormat!.split(",");
    return Container(
      height: height,
      child: ListView(
        padding: EdgeInsets.fromLTRB(
            kIsWeb ? 10.0 : 8.0, kIsWeb ? 5.0 : 3.0, 10.0, 0.0),
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Text(
                merchant.name!,
                style: textStyleMerchantTitle,
                maxLines: 1,
              )),
          const SizedBox(
            height: 3,
          ),
          SingleChildScrollView(
              padding: EdgeInsets.all(0.0),
              scrollDirection: Axis.horizontal,
              child: Text(
                merchant.location!,
                maxLines: 1,
                style: textStyleMerchantLocation,
              )),
          isWebMobile
              ? SizedBox(
                  height: 0.01,
                )
              : SizedBox(
                  height: kIsWeb ? 4.0 : 0.01,
                ),
          SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Wrap(
                  spacing: 5.0,
                  children: buildTagTextItems(context, splittedTags))),
        ],
      ),
    );
  }

  List<Widget> buildTagTextItems(ctx, List<String> splittedTags) {
    return splittedTags.map((tagId) {
      if (tagId == "104")
        return SizedBox(); //return empty box in case of placeholder tag 104
      var parsedTag = TagCoinector.parseTag(ctx, tagId);
      var splittedTag = parsedTag.split(" ");
      return HoverButton(
          padding: EdgeInsets.all(0.0),
          hoverPadding: EdgeInsets.all(0.0),
          onpressed: () => restartWidgetWithFilter(ctx, tagId),
          child: Row(children: [
            Text(splittedTag[0].toUpperCase(),
                style: TextStyle(
                    textBaseline: TextBaseline.alphabetic,
                    fontSize: 15.0,
                    fontWeight: kIsWeb ? FontWeight.w300 : FontWeight.w500,
                    color: Colors.white)),
            Text(splittedTag.length > 1 ? " " + splittedTag[1] : "",
                style: TextStyle(fontSize: 16.0)),
          ]));
    }).toList();
  }

  void restartWidgetWithFilter(ctx, String title) {
    filterCallback.doFilter(TagCoinector.parseTag(ctx, title));
  }
}
