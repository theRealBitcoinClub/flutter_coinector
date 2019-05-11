import 'package:coinector/TagParser.dart';
import 'package:coinector/pages.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'Merchant.dart';
import 'ListModel.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

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

  static CameraPosition initialCamPos = CameraPosition(
    target: LatLng(41.4027984, 2.1600427),
    zoom: 10, //This position reflect Vila de Gracia Barcelona, Quinoa Bar
  );

  MapSampleState(this.allLists, this.position, this.initialZoomLevel);
  Set<Marker> allMarkers = Set.from([]);

  DateTime lastTap;
  Merchant selectedMerchant;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allMarkers.clear();
    if (position != null)
      initialCamPos = CameraPosition(
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
/*
                if (lastTap != null &&
                    new DateTime.now().millisecondsSinceEpoch -
                            lastTap.millisecondsSinceEpoch <
                        1000) {
                  Navigator.of(context).pop(merchant);
                } else {
                  //TODO explain the user that he has to double click to open the details
                }
                lastTap = new DateTime.now();*/
                setState(() {
                  selectedMerchant = merchant;
                });

                //confirmShowDetails(context, merchant);
              },
              infoWindow: buildInfoWindow(merchant),
              icon: getMarkerColor(merchant),
              markerId: MarkerId(merchant.id),
              position: latLng));
        }
      }
      if (allMarkers.length == 1) {
        initialCamPos = CameraPosition(target: latLng, zoom: 15.0);
      }
      //print("markers:" + allMarkers.length.toString());
    }
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
          closeMapReturnMerchant();
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
      body: GoogleMap(
        onTap: (pos) {
          setState(() {
            selectedMerchant = null;
          });
        },
        compassEnabled: true,
        myLocationEnabled: true,
        mapType: MapType.normal,
        markers: allMarkers,
        initialCameraPosition: hasMarkers()
            ? initialCamPos
            : hasMarkers() ? allMarkers.elementAt(0).position : initialCamPos,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).backgroundColor,
        foregroundColor: Theme.of(context).accentColor,
        onPressed: closeMapReturnMerchant,
        label: Text(selectedMerchant == null ? 'CLOSE' : 'DETAILS'),
        icon: Icon(selectedMerchant == null ? Icons.close : Icons.search),
      ),
    );
  }

  bool hasMarkers() => allMarkers != null && allMarkers.length > 1;

  Future<void> closeMapReturnMerchant() async {
    Navigator.of(context).pop(selectedMerchant);
  }
}
