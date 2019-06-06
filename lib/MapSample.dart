import 'dart:async';

import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'ListModel.dart';
import 'Merchant.dart';
import 'TagParser.dart';
import 'Toaster.dart';
import 'pages.dart';

var sharedPrefKeyCounterToastGeneral = "sharedPrefKeyCounterToastGeneral2";
var sharedPrefKeyCounterToastSpecific = "sharedPrefKeyCounterToastSpecific2";
const initialZoomFallbackWhenPositionIsProvided = 15.0;

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

  Set<Marker> parseListAndZoomToSingleResult(ctx) {
    allMarkers = parseListBuildMarkers(ctx);
    if (allMarkers.length == 1) {
      initialCamPosFallback = CameraPosition(
          target: latLngLastParsedItem,
          zoom: initialZoomFallbackWhenPositionIsProvided);
    }
    return allMarkers;
  }

  LatLng latLngLastParsedItem;

  Set<Marker> parseListBuildMarkers(ctx) {
    if (getTotalLengthOFAllLists() == allMarkers.length) allMarkers.clear();
    for (int tabCounter = 0; tabCounter < allLists.length; tabCounter++) {
      ListModel<Merchant> listMerchants = allLists[tabCounter];
      for (int itemCounter = 0;
          itemCounter < listMerchants.length;
          itemCounter++) {
        var merchant = listMerchants[itemCounter];
        latLngLastParsedItem =
            LatLng(double.parse(merchant.x), double.parse(merchant.y));
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
        snippet: FlutterI18n.translate(context, buildTypeSnippet(merchant)) +
            " at " +
            buildAdrSnippet(merchant));
  }

  String buildTypeSnippet(Merchant m) {
    return Pages
        .pages[m.type == 999 ? 6 : m.type].text; //type 999 gets mapped to tab 6
  }

  String buildAdrSnippet(Merchant merchant) {
    return (merchant.place != null)
        ? merchant.place.adr.substring(merchant.place.adr.indexOf(",") + 2)
        : merchant.location;
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
            onMapCreated: (GoogleMapController controller) {
              var parsedMarkers = parseListAndZoomToSingleResult(context);
              setState(() {
                allMarkers = parsedMarkers;
              });
              _controller.complete(controller);
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Theme.of(ctx).backgroundColor,
          foregroundColor: Theme.of(ctx).accentColor,
          onPressed: closeMapResetMerchant,
          label: Text(FlutterI18n.translate(ctx, 'close_map')),
          icon: Icon(Icons.close),
        ),
      );
    });
  }

  //TODO delay the image load to avoid the exceptions on startup???

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
