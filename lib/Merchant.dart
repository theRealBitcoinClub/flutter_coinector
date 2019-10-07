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
  String tags;
  String location;
  String serverId;
  Place place;
  String distance;
  double distanceInMeters = -1;
  String geohash;
  //LatLngAndGeohash latLngAndGeohash;

  /*calcGeoHash () {
    geohash = Geohash.encode(x,y);
    latLngAndGeohash = LatLngAndGeohash(LatLng(x, y));
  }*/

  Merchant(this.id, this.x, this.y, this.name, this.type, this.reviewCount,
      this.reviewStars, this.discount, this.tags, this.location);

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
        location = json['l'];


}
