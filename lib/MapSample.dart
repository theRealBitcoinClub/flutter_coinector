import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'Merchant.dart';
import 'ListModel.dart';

class MapSample extends StatefulWidget {
  final ListModel<Merchant> listMerchants;

  MapSample(this.listMerchants);

  @override
  State<MapSample> createState() => MapSampleState(listMerchants);
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  final ListModel<Merchant> listMerchants;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 10.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  MapSampleState(this.listMerchants);

  @override
  Widget build(BuildContext context) {
    Set<Marker> allMarkers = Set.from([]);
    if (listMerchants != null) {
      for (int i = 0; i < listMerchants.length; i++) {
        var merchant = listMerchants[i];
        allMarkers.add(Marker(
            markerId: MarkerId(merchant.id),
            position:
                LatLng(double.parse(merchant.x), double.parse(merchant.y))));
      }
    }

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
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
