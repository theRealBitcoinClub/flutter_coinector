import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'ListModel.dart';
import 'Merchant.dart';
import 'TagParser.dart';
import 'pages.dart';

var sharedPrefKeyCounterToastGeneral = "sharedPrefKeyCounterToastGeneral";
var sharedPrefKeyCounterToastSpecific = "sharedPrefKeyCounterToastSpecific";
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

  Future<void> initToastCounter() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    counterToastGeneral = getCounterFromPrefsWithDefaultValue(
        prefs, sharedPrefKeyCounterToastGeneral);
    counterToastSpecific = getCounterFromPrefsWithDefaultValue(
        prefs, sharedPrefKeyCounterToastSpecific);
  }

  int getCounterFromPrefsWithDefaultValue(SharedPreferences prefs, key) {
    var counterTmp = prefs.getInt(key);
    return counterTmp != null ? counterTmp : 0;
  }

  Future incrementAndPersistToastCounterGeneral() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    counterToastGeneral = getCounterFromPrefsWithDefaultValue(prefs, sharedPrefKeyCounterToastGeneral);
    setState(() {
      counterToastGeneral++;
    });
    prefs.setInt(sharedPrefKeyCounterToastGeneral, counterToastGeneral);
  }

  Future incrementAndPersistToastCounterSpecific() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    counterToastSpecific = getCounterFromPrefsWithDefaultValue(prefs, sharedPrefKeyCounterToastSpecific);
    setState(() {
      counterToastSpecific++;
    });
    prefs.setInt(sharedPrefKeyCounterToastSpecific, counterToastSpecific);
  }

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
                showToast(counterToastSpecific, getMerchantSpecificToastHint);
                incrementAndPersistToastCounterSpecific();
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

  void showToast(showToastCount, msgProvider) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: msgProvider(HINT_COUNT_TOTAL),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 3,
        backgroundColor: Colors
            .primaries[(showToastCount % HINT_COUNT_TOTAL) * 2]
            .withOpacity(0.8),
        textColor: Colors.white,
        fontSize: 14.0);
  }

  String getGeneralToastHint(totalHintCounter) {
    switch (counterToastGeneral % totalHintCounter) {
      case 0:
        return "MARKER: Tap any marker to see more information of that selected place.";
      case 1:
        return "LOCATION: Tap the location button (top right) to zoom to your current location.";
      case 2:
        return "CLOSE: Tap the close button (bottom) to see the complete list of all places worldwide.";
    }
    return "";
  }

  String getMerchantSpecificToastHint(totalHintCounter) {
    switch (counterToastSpecific % totalHintCounter) {
      case 0:
        return "DETAILS: Tap the info box to load the details of that place.";
      case 1:
        return "ROUTE: Tap the route button (bottom right), to navigate to the selected place.";
      case 2:
        return "MAP: Tap the map at any free space, to close the info box of a selected place.";
    }
    return "";
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
            showToast(counterToastGeneral, getGeneralToastHint);
            incrementAndPersistToastCounterGeneral();
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
