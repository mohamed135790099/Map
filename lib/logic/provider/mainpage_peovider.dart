import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../services/request_methods.dart';

class MainProvider extends ChangeNotifier {
  static String? addressName;
  final CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  final Completer<GoogleMapController> controller = Completer();

  GoogleMapController? googleMapController;
  double mapBottomPadding = 0;
  var locator = Geolocator();
  Position? currentPosition;

  void setupPositionLocator(BuildContext context) async {
    try {
      LocationPermission permission;
      await Geolocator.requestPermission();
      permission = await Geolocator.checkPermission();
      if (permission != LocationPermission.denied) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        currentPosition = position;
        LatLng pos = LatLng(position.latitude, position.longitude);
        CameraPosition cP = CameraPosition(
          target: pos,
          zoom: 14.4746,
        );
        googleMapController!.animateCamera(CameraUpdate.newCameraPosition(cP));
        String currentPlace = await RequestMethods.searchCoordinatePlace(position, context);
          // debugPrint("=================================================================");
         // debugPrint("This is Address========$currentPlace");
        // debugPrint("=================================================================");

      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  notifyListeners();
}
