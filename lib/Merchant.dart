//{"p":"trbc", "x":"41.406595", "y":"2.16655","n":"TRBC - The Real Bitcoin Club", "t":"99","c":"3","s":"5.0", "d":"3", "a":"0,1,2,34", "l":"Barcelona, Spain, Europe"}

import 'Place.dart';
//import 'package:geohash/geohash.dart';
//import 'package:clustering_google_maps/clustering_google_maps.dart';
//import 'package:geolocator/geolocator.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';

class Merchant {
  bool isPayEnabled = false;
  int index;
  String id;
  double x;
  double y;
  String name;
  int type;
  String reviewCount;
  String reviewStars;
  int discount;
  String
      tags; //TODO SPLIT THE TAGS ONE TIME AND SAVE THEM IN TWO ARRAYS ONE INT ARRAY FOR SEARCH AND ONE STRING ARRAY WITH PARSED TAGS
  String location;
  String serverId; //TODO RENAME THIS VARIABLE
  Place place;
  String distance;
  double distanceInMeters = -1;
  String geohash;
  int brand; //TODO LET USER TAP THE BRAND TO SEE ONLY THE SAME BRAND
  String acceptedCoins; //TODO SPLIT TAGS ON FIRST READ
  //LatLngAndGeohash latLngAndGeohash;

  /*calcGeoHash () {
    geohash = Geohash.encode(x,y);
    latLngAndGeohash = LatLngAndGeohash(LatLng(x, y));
  }*/
  String getBmapDataJson() {
    return '{"p":"' +
        id +
        '","x":"' +
        x.toString() +
        '","y":"' +
        y.toString() +
        '","n":"' +
        name +
        '","t":"' +
        type.toString() +
        '","c":"' +
        reviewCount.toString() +
        '","s":"' +
        reviewStars.toString() +
        '","d":"' +
        discount.toString() +
        '","l":"' +
        location +
        '","b":"' +
        brand.toString() +
        '","w":"' +
        acceptedCoins +
        '"}';
  }

  Merchant(
      this.id,
      this.x,
      this.y,
      this.name,
      this.type,
      this.reviewCount,
      this.reviewStars,
      this.discount,
      this.tags,
      this.location,
      this.brand,
      this.acceptedCoins);

  // named constructor
  Merchant.fromJson(Map<String, dynamic> json)
      : id = json['p'],
        x = double.parse(json['x']),
        y = double.parse(json['y']),
        name = json['n'],
        type = int.parse(json['t']),
        reviewCount = json['c'],
        reviewStars = json['s'],
        discount = int.parse(json['d']),
        tags = json['a'],
        //TODO use one single source of locations, take the suggestions or the placesIDAddress as reference
        location = json['l'],
        brand = json['b'] != null ? int.parse(json['b']) : null,
        acceptedCoins = json['w'];
}
