import 'dart:async';

import 'package:Coinector/translator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//import 'package:place_picker/place_picker.dart';

import 'ListModel.dart';
import 'Merchant.dart';
import 'TagParser.dart';
import 'Toaster.dart';
import 'pages.dart';

var sharedPrefKeyCounterToastGeneral = "sharedPrefKeyCounterToastGeneral2";
var sharedPrefKeyCounterToastSpecific = "sharedPrefKeyCounterToastSpecific2";
const initialZoomFallbackWhenPositionIsProvided = 15.0;
const String MAP_STYLE =
    '[{"elementType":"geometry","stylers":[{"color":"#212121"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#212121"}]},{"featureType":"administrative","elementType":"geometry","stylers":[{"color":"#757575"},{"visibility":"off"}]},{"featureType":"administrative.country","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"administrative.land_parcel","stylers":[{"visibility":"off"}]},{"featureType":"administrative.locality","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","stylers":[{"visibility":"off"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","stylers":[{"visibility":"on"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#181818"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"poi.park","elementType":"labels.text.stroke","stylers":[{"color":"#1b1b1b"}]},{"featureType":"road","elementType":"geometry.fill","stylers":[{"color":"#2c2c2c"}]},{"featureType":"road","elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#8a8a8a"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#373737"}]},{"featureType":"road.highway","stylers":[{"visibility":"off"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#3c3c3c"}]},{"featureType":"road.highway.controlled_access","stylers":[{"visibility":"off"}]},{"featureType":"road.highway.controlled_access","elementType":"geometry","stylers":[{"color":"#4e4e4e"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"transit","stylers":[{"visibility":"on"}]},{"featureType":"transit","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"transit.station.airport","stylers":[{"visibility":"off"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#000000"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#3d3d3d"}]}]';

class MapSample extends StatefulWidget {
  final List<ListModel<Merchant>> allLists;
  final Position position;
  final double initialZoomLevel;

  MapSample(this.allLists, this.position, this.initialZoomLevel);

  @override
  State<MapSample> createState() =>
      MapSampleState(allLists, position, initialZoomLevel);
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  final List<ListModel<Merchant>> allLists;
  final Position position;
  final double initialZoomLevel;
  int counterToastGeneral = 0;
  int counterToastSpecific = 0;

  static CameraPosition initialCamPosFallback = CameraPosition(
    target: LatLng(41.4027984, 2.1600427),
    zoom: 10, //This position reflect Vila de Gracia Barcelona, Quinoa Bar
  );

  static const int HINT_COUNT_TOTAL = 3;

  static const SHOW_HINT_MAX_COUNTER = HINT_COUNT_TOTAL * 2;

  GoogleMapController _googleMapController;

  MapSampleState(this.allLists, this.position, this.initialZoomLevel);
  Set<Marker> allMarkers = Set.from([]);

  Toaster toast = Toaster();

  @override
  void initState() {
    super.initState();
    initToastCounter();
    if (position != null)
      initialCamPosFallback = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: initialZoomLevel);
/*
    if (allLists != null) {
      parseListAndZoomToSingleResult();
    }*/
  }

  Future<Set<Marker>> parseListAndZoomToSingleResult(ctx) async {
    allMarkers = await parseListBuildMarkers(ctx);
    if (allMarkers.length == 1) {
      initialCamPosFallback = CameraPosition(
          target: latLngLastParsedItem,
          zoom: initialZoomFallbackWhenPositionIsProvided);
    }
    return allMarkers;
  }

  LatLng latLngLastParsedItem;

  /*void _showPlacePicker() async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            PlacePicker("YOUR API KEY")));

    // Handle the result in your way
    print(result);
  }*/

  Future<Set<Marker>> parseListBuildMarkers(ctx) async {
    //if (getTotalLengthOFAllLists() == allMarkers.length) allMarkers.clear();
    allMarkers.clear();
    final latLngBounds = await _googleMapController.getVisibleRegion();
    //print("LATLNG:" + latLngBounds.contains(LatLng(42.0, -111.0)).toString());
    for (int tabCounter = 0; tabCounter < allLists.length; tabCounter++) {
      ListModel<Merchant> listMerchants = allLists[tabCounter];
      for (int itemCounter = 0;
          itemCounter < listMerchants.length;
          itemCounter++) {
        var merchant = listMerchants[itemCounter];
        latLngLastParsedItem = LatLng(merchant.x, merchant.y);
        if (latLngBounds.contains(latLngLastParsedItem))
          allMarkers.add(Marker(
              onTap: () {
                if (counterToastSpecific >= SHOW_HINT_MAX_COUNTER) return;
                Toaster.showInstructionToast(ctx, counterToastSpecific,
                    HINT_COUNT_TOTAL, Toaster.getMerchantSpecificToastHint);

                setState(() {
                  counterToastSpecific++;
                });
                Toaster.persistToastCounter(
                    sharedPrefKeyCounterToastSpecific, counterToastSpecific);
              },
              infoWindow: buildInfoWindow(merchant),
              icon: getMarkerColor(merchant),
              markerId: MarkerId(merchant.id),
              position: latLngLastParsedItem));
      }
    }
    return allMarkers;
  }

  Future initToastCounter() async {
    counterToastSpecific =
        await Toaster.initToastCounter(sharedPrefKeyCounterToastSpecific);
    counterToastGeneral =
        await Toaster.initToastCounter(sharedPrefKeyCounterToastGeneral);
  }

  BitmapDescriptor getMarkerColor(Merchant m) {
    const ORANGE = 20.0;
    const YELLOW = 50.0;
    const CYAN = 190.0;
    const GREEN = 140.0;
    const MAGENTA = 310.0;
    const VIOLET = 270.0;

    switch (m.type) {
      case 0:
        return BitmapDescriptor.defaultMarkerWithHue(ORANGE);
      case 1:
        return BitmapDescriptor.defaultMarker;
      case 2:
        return BitmapDescriptor.defaultMarkerWithHue(YELLOW);
      case 3:
        return BitmapDescriptor.defaultMarkerWithHue(CYAN);
      case 4:
        return BitmapDescriptor.defaultMarkerWithHue(MAGENTA);
      case 5:
        return BitmapDescriptor.defaultMarkerWithHue(GREEN);
      case 999:
        return BitmapDescriptor.defaultMarkerWithHue(VIOLET);
    }
    return BitmapDescriptor.defaultMarker;
  }

  InfoWindow buildInfoWindow(Merchant merchant) {
    return InfoWindow(
        title: merchant.name +
            ": " +
            TagParser.parseTagIndexToText(merchant.tags.split(","))
                .toUpperCase(),
        onTap: () {
          closeMapReturnMerchant(merchant);
        },
        snippet: Translator.translate(context, buildTypeSnippet(merchant)) +
            " at " +
            buildAdrSnippet(merchant));
  }

  String buildTypeSnippet(Merchant m) {
    return Pages
        .pages[m.type == 999 ? 6 : m.type].text; //type 999 gets mapped to tab 6
  }

  String buildAdrSnippet(Merchant merchant) {
    return merchant.location;
  }

  @override
  Widget build(BuildContext ctx) {
    return Builder(builder: (buildCtx) {
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 25.0),
          child: GoogleMap(
            onTap: (pos) {
              if (counterToastGeneral >= SHOW_HINT_MAX_COUNTER) return;
              Toaster.showInstructionToast(buildCtx, counterToastGeneral,
                  HINT_COUNT_TOTAL, Toaster.getGeneralToastHint);
              setState(() {
                counterToastGeneral++;
              });
              Toaster.persistToastCounter(
                  sharedPrefKeyCounterToastGeneral, counterToastGeneral);
            },
            compassEnabled: true,
            myLocationEnabled: true,
            mapType: MapType.normal,
            markers: allMarkers,
            initialCameraPosition: hasMarkers()
                ? initialCamPosFallback
                : hasMarkers()
                    ? allMarkers.elementAt(0).position
                    : initialCamPosFallback,
            onCameraIdle: () async {
              _parseAndUpdateMarkers();
            },
            onMapCreated: (GoogleMapController controller) {
              _googleMapController = controller;
              controller.setMapStyle(MAP_STYLE);
              _controller.complete(controller);
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.white70,
          foregroundColor: Theme.of(ctx).backgroundColor,
          onPressed: closeMapResetMerchant,
          label: Text(Translator.translate(ctx, 'close_map')),
          icon: Icon(Icons.close),
        ),
      );
    });
  }

  _parseAndUpdateMarkers() async {
    var parsedMarkers = await parseListAndZoomToSingleResult(context);
    setState(() {
      allMarkers = parsedMarkers;
    });
  }

  bool hasMarkers() => allMarkers != null && allMarkers.length > 1;

  Future<void> closeMapResetMerchant() async {
    cancelToasts();
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    cancelToasts();
    super.dispose();
  }

  void cancelToasts() {
    Fluttertoast.cancel();
  }

  Future<void> closeMapReturnMerchant(merchant) async {
    cancelToasts();
    Navigator.of(context).pop(merchant);
  }

  int getTotalLengthOFAllLists() {
    int index = 0;
    allLists.forEach((ListModel<Merchant> merchants) {
      for (int x = 0; x < merchants.length; x++) {
        index++;
      }
    });
    return index;
  }
}
