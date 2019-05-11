//{"p":"trbc", "x":"41.406595", "y":"2.16655","n":"TRBC - The Real Bitcoin Club", "t":"99","c":"3","s":"5.0", "d":"3", "a":"0,1,2,34", "l":"Barcelona, Spain, Europe"}

import 'package:coinector/Place.dart';

class Merchant {
  bool isPayEnabled = false;
  int index;
  String id;
  String x;
  String y;
  String name;
  int type;
  String reviewCount;
  String reviewStars;
  int discount;
  String tags;
  String location;
  String serverId;
  Place place;
  String distance;
  double distanceInMeters = -1;

  Merchant(this.id, this.x, this.y, this.name, this.type, this.reviewCount,
      this.reviewStars, this.discount, this.tags, this.location);

  // named constructor
  Merchant.fromJson(Map<String, dynamic> json)
      : id = json['p'],
        x = json['x'],
        y = json['y'],
        name = json['n'],
        type = int.parse(json['t']),
        reviewCount = json['c'],
        reviewStars = json['s'],
        discount = int.parse(json['d']),
        tags = json['a'],
  //TODO use one single source of locations, take the suggestions or the placesIDAddress as reference
        location = json['l'];


}
