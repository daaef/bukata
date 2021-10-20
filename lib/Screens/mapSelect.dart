import 'dart:collection';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:ui' as ui;

class MapSelect extends StatefulWidget {
  @override
  _MapSelectState createState() => _MapSelectState();
}

class _MapSelectState extends State<MapSelect> {
  bool _isLoading = true;
  Position _currentPosition;
  Set<Marker> _markers = HashSet<Marker>();
  GoogleMapController _mapController;
  BitmapDescriptor _markerIcon;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId("0"),
            position: LatLng(
              _currentPosition.latitude,
              _currentPosition.longitude,
            ),
            icon: _markerIcon,
            infoWindow: InfoWindow(
                title: "Pickup Location",
                snippet: "The package will be picked up here.")),
      );
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  void setMarkerIcon() async {
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/pointer.png', 50);
    _markerIcon = BitmapDescriptor.fromBytes(markerIcon);
    // _markerIcon = await BitmapDescriptor.fromAssetImage(
    //     ImageConfiguration(), "assets/pointer.png");
  }

  getPosition() async {
    Position position =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
      _isLoading = false;
    });
    print(position);
  }

  @override
  void initState() {
    getPosition();
    setMarkerIcon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _isLoading
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Center(
                child: SpinKitChasingDots(
                  color: Colors.orange[800],
                  size: 50.0,
                ),
              ),
            )
          : GoogleMap(
              onMapCreated: _onMapCreated,
              markers: _markers,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  _currentPosition.latitude,
                  _currentPosition.longitude,
                ),
                zoom: 15,
              )),
    );
  }
}
