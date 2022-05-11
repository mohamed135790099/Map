import 'package:app_rider/logic/model/address_model.dart';
import 'package:app_rider/logic/provider/adress_provider.dart';
import 'package:app_rider/logic/provider/mainpage_peovider.dart';
import 'package:app_rider/resources/mystring.dart';
import 'package:app_rider/services/request_assistance.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import '../model/directions_place.dart';

class GetPlaceDirection extends ChangeNotifier {
  List<LatLng> polylineCoordinates = [];
  Set<Polyline> ployLineSet = {};

  Address? initialPosition;
  PlaceDirection? locationDetails;

  Address? finalPosition;
  LatLng? pickUpPosition;
  LatLng? dropOffPosition;

  //obtain place direction
  Future<PlaceDirection?> obtainPlaceDirectionDetails(
      LatLng initialPosition, LatLng finalPosition,BuildContext context) async {
    String urlDirection =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=$google_map';
    var res = await RequestAssistance.getRequest(urlDirection);
    if (res == 'Failed') {
      return null;
    }

    PlaceDirection placeDirection = PlaceDirection();
    if (res['status'] == "OK") {
      placeDirection.distanceValue =
          res["routes"][0]["legs"][0]["distance"]["value"];
      placeDirection.distanceText =
          res["routes"][0]["legs"][0]["distance"]["text"];
      placeDirection.durationValue =
          res["routes"][0]["legs"][0]["duration"]["value"];
      placeDirection.distanceText =
          res["routes"][0]["legs"][0]["duration"]["text"];
      placeDirection.endCodePoint =
          res["routes"][0]["overview_polyline"]["points"];
    }
    locationDetails=placeDirection;


    notifyListeners();

    return placeDirection;
  }

  //get place direction
  Future<void> placeDirection(BuildContext context) async {

    var initialPos = Provider.of<AddressProvider>(context, listen: false).userPickupAddress;
    var finalPos = Provider.of<AddressProvider>(context, listen: false).userDropOffAddress;
    initialPosition=initialPos;
    finalPosition=finalPos;
    notifyListeners();

    LatLng pickUpLatLng = LatLng(initialPos!.latitude!, initialPos.longitude!);
    LatLng dropOffLatLng = LatLng(finalPos!.latitude!, finalPos.longitude!);
    var details = await obtainPlaceDirectionDetails(pickUpLatLng, dropOffLatLng,context);

    pickUpPosition=pickUpLatLng;
    dropOffPosition=dropOffLatLng;
    notifyListeners();

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodePolyLinePointsResult = polylinePoints.decodePolyline(details!.endCodePoint!);
    polylineCoordinates.clear();
    ployLineSet.clear();
    if (decodePolyLinePointsResult.isNotEmpty) {
      for (var pointLatLng in decodePolyLinePointsResult) {
        polylineCoordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      }
    }
    notifyListeners();

    // new camera position this give summary about routes you walk to arrive to destination
    LatLngBounds latLngBounds;
    if (pickUpLatLng.latitude > dropOffLatLng.latitude &&
        pickUpLatLng.longitude > dropOffLatLng.longitude) {
      latLngBounds = LatLngBounds(
        southwest: pickUpLatLng,
        northeast: dropOffLatLng,
      );
    } else if (pickUpLatLng.latitude > dropOffLatLng.latitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(pickUpLatLng.latitude, dropOffLatLng.latitude),
          northeast: LatLng(pickUpLatLng.longitude, dropOffLatLng.longitude));
    } else if (pickUpLatLng.longitude > dropOffLatLng.longitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(dropOffLatLng.longitude, pickUpLatLng.longitude),
          northeast: LatLng(dropOffLatLng.longitude, pickUpLatLng.latitude));
    } else {
      latLngBounds = LatLngBounds(
        southwest: dropOffLatLng,
        northeast: pickUpLatLng,
      );
    }
    Provider.of<MainProvider>(context,listen:false).googleMapController!.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));
    notifyListeners();

  }
}
