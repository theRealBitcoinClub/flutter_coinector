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

  MapSample(this.allLists, this.position);

  @override
  State<MapSample> createState() => MapSampleState(allLists, position);
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  final List<ListModel<Merchant>> allLists;
  final Position position;

  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(41.4027984, 2.1600427),
    zoom: 10,
  );

  MapSampleState(this.allLists, this.position);
  Set<Marker> allMarkers = Set.from([]);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (position != null)
      _kGooglePlex = CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 10.0);

    if (allLists != null) {
      for (int tabCounter = 0; tabCounter < allLists.length; tabCounter++) {
        ListModel<Merchant> listMerchants = allLists[tabCounter];
        for (int itemCounter = 0;
            itemCounter < listMerchants.length;
            itemCounter++) {
          var merchant = listMerchants[itemCounter];
          allMarkers.add(Marker(
              infoWindow: buildInfoWindow(merchant),
              icon: getMarkerColor(merchant),
              markerId: MarkerId(merchant.id),
              position:
                  LatLng(double.parse(merchant.x), double.parse(merchant.y))));
        }
      }
    }
  }

  BitmapDescriptor getMarkerColor(Merchant m) {
    switch (m.type) {
      case 0:
        return BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueOrange);
      case 1:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
      case 2:
        return BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueYellow);
      case 3:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan);
      case 4:
        return BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueMagenta);
      case 5:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
      case 6:
        return BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueViolet);
    }
    return BitmapDescriptor.defaultMarker;
  }

  InfoWindow buildInfoWindow(Merchant merchant) {
    return InfoWindow(
        title: merchant.name,
        snippet: (merchant.place != null)
            ? merchant.place.adr.substring(merchant.place.adr.indexOf(",") + 2)
            : merchant.location);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        compassEnabled: true,
        myLocationEnabled: true,
        mapType: MapType.normal,
        markers: allMarkers,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    //controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
