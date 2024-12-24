import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'Merchant.dart';

class RatingWidgetBuilder {
  static Widget buidRatingWidget(Merchant m, textStyle) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SmoothStarRating(
              allowHalfRating: true,
              starCount: 5,
              isReadOnly: true,
              rating: double.parse(m.reviewStars),
              size: 15.0,
              color: Colors.yellow[700],
              borderColor: Colors.white,
            ),
            Text(" " + convertRatingToPercentage(m.reviewStars), style: textStyle)
            //buildTextStarCount(m, textStyle),
          ],
        ),
        /*SizedBox(height: 5),
        Row(
          children: <Widget>[
            Text(convertRatingToPercentage(m.reviewStars) + " positive", //TODO add some funny names to classify the quality of the service
                style: textStyle),
          ],
        )*/
      ],
    );
  }

  static Text buildTextStarCount(Merchant m, textStyle) {
    return Text(
      " (" + m.reviewStars + ")",
      style: textStyle,
    );
  }

  static Widget buildRatingWidgetIfReviewsAvailable(
      Merchant m, TextStyle style) {
    return !RatingWidgetBuilder.hasReviews(m)
        ? Padding(
            padding: EdgeInsets.all(0.0),
          )
        : RatingWidgetBuilder.buidRatingWidget(m, style);
  }

  static String convertRatingToPercentage(String stars) {
    return (double.parse(stars) * 20).round().toString() + "%";
  }

  static bool hasReviews(item) => item.reviewCount != '0';
}
