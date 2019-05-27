import 'dart:async';

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
    allMarkers.clear();
    if (position != null)
      initialCamPosFallback = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: initialZoomLevel);

    if (allLists != null) {
      var latLng;
      for (int tabCounter = 0; tabCounter < allLists.length; tabCounter++) {
        ListModel<Merchant> listMerchants = allLists[tabCounter];
        for (int itemCounter = 0;
            itemCounter < listMerchants.length;
            itemCounter++) {
          var merchant = listMerchants[itemCounter];
          latLng = LatLng(double.parse(merchant.x), double.parse(merchant.y));
          allMarkers.add(Marker(
              onTap: () {
                if (counterToastSpecific >= SHOW_HINT_MAX_COUNTER) return;
                Toaster.showInstructionToast(counterToastSpecific,
                    HINT_COUNT_TOTAL, Toaster.getMerchantSpecificToastHint);
                Toaster.incrementAndPersistToastCounter(
                    sharedPrefKeyCounterToastSpecific);

                setState(() {
                  counterToastSpecific++;
                });
              },
              infoWindow: buildInfoWindow(merchant),
              icon: getMarkerColor(merchant),
              markerId: MarkerId(merchant.id),
              position: latLng));
        }
      }
      if (allMarkers.length == 1) {
        initialCamPosFallback = CameraPosition(
            target: latLng, zoom: initialZoomFallbackWhenPositionIsProvided);
      }
    }
  }

  Future initToastCounter() async {
    counterToastSpecific =
        await Toaster.initToastCounter(sharedPrefKeyCounterToastSpecific);
    counterToastGeneral =
        await Toaster.initToastCounter(sharedPrefKeyCounterToastGeneral);
  }

  void confirmShowDetails(BuildContext context, Merchant merchant) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            content: Text("Do you want to see the details of that place?"),
            title: Text("Show details?", style: TextStyle(color: Colors.white)),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("NO"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(merchant);
                },
                child: Text("YES"),
              )
            ],
          );
        });
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
        snippet:
            buildTypeSnippet(merchant) + " at " + buildAdrSnippet(merchant));
  }

  String buildTypeSnippet(Merchant m) {
    return Pages.pages[m.type == 999 ? 6 : m.type]
        .title; //type 999 gets mapped to tab 6
  }

  String buildAdrSnippet(Merchant merchant) {
    return (merchant.place != null)
        ? merchant.place.adr.substring(merchant.place.adr.indexOf(",") + 2)
        : merchant.location;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 25.0),
        child: GoogleMap(
          onTap: (pos) {
            if (counterToastGeneral >= SHOW_HINT_MAX_COUNTER) return;
            Toaster.showInstructionToast(counterToastGeneral, HINT_COUNT_TOTAL,
                Toaster.getGeneralToastHint);
            Toaster.incrementAndPersistToastCounter(
                sharedPrefKeyCounterToastGeneral);

            setState(() {
              counterToastGeneral++;
            });
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
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).backgroundColor,
        foregroundColor: Theme.of(context).accentColor,
        onPressed: closeMapResetMerchant,
        label: Text('CLOSE MAP'),
        icon: Icon(Icons.close),
      ),
    );
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
}
