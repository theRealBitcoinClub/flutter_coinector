//{"p":"trbc", "x":"41.406595", "y":"2.16655","n":"TRBC - The Real Bitcoin Club", "t":"99","c":"3","s":"5.0", "d":"3", "a":"0,1,2,34", "l":"Barcelona, Spain, Europe"}

import 'package:Coinector/TagCoinector.dart';

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
      tagsDatabaseFormat; //TODO SPLIT THE TAGS ONE TIME AND SAVE THEM IN TWO ARRAYS ONE INT ARRAY FOR SEARCH AND ONE STRING ARRAY WITH PARSED TAGS
  Set<TagCoinector> tagsInput;
  String location;
  String
      serverIdOrFileName; //TODO PROGRAM A BACKUP SERVER IF GITHUB CANT SERVE DATA USE FIREBASE AND IF THATS ALSO BLOCKED THEN USE IPFS
  Place place;
  String distance;
  double distanceInMeters = -1;
  String geohash;
  int brand; //TODO LET USER TAP THE BRAND TO SEE ONLY THE SAME BRAND
  String acceptedCoins; //TODO SPLIT TAGS ON FIRST READ

  var placeDetailsData;
  //LatLngAndGeohash latLngAndGeohash;

  /*calcGeoHash () {
    geohash = Geohash.encode(x,y);
    latLngAndGeohash = LatLngAndGeohash(LatLng(x, y));
  }*/

  static Merchant createMerchantFromInputs(
      data, placeId, Set<TagCoinector> tagsInput, int placeType) {
    var location = data["geometry"]["location"];
    var cleanAdr =
        data["adr_address"].toString().replaceAll(RegExp('<[^>]+>'), '').trim();
    print(cleanAdr);
    Merchant m = Merchant(
        placeId,
        location["lat"],
        location["lng"],
        data["name"],
        placeType /*TODO add function to map google types to bmap types*/,
        data["user_ratings_total"].toString(),
        data["rating"].toString(),
        0,
        TagCoinector.parseTagsToDatabaseFormat(tagsInput),
        cleanAdr,
        null,
        null);
    m.tagsInput = tagsInput;
    //create fake Place object to use new id thats equal to place id
    if (m.id.length == 27) m.place = new Place(m.id, m.id);
    return m;
  }

  String getBmapDataJson() {
    return '{"p":"' +
        id +
        '","x":"' +
        x.toString() +
        '","y":"' +
        y.toString() +
        '","n":"' +
        name.replaceAll('"', '') +
        '","t":"' +
        type.toString() +
        '","c":"' +
        (reviewCount != "null" ? reviewCount.toString() : '0') +
        '","s":"' +
        (reviewStars != "null" ? reviewStars.toString() : '0.0') +
        '","d":"' +
        discount.toString() +
        '","a":"' +
        tagsDatabaseFormat +
        '","l":"' +
        location.replaceAll('"', '') +
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
      this.tagsDatabaseFormat,
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
        tagsDatabaseFormat = json['a'],
        //TODO use one single source of locations, take the suggestions or the placesIDAddress as reference
        location = json['l'],
        brand = json['b'] != null ? int.parse(json['b']) : null,
        acceptedCoins = json['w'];
}
