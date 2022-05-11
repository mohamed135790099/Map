import 'package:app_rider/logic/model/address_model.dart';
import 'package:app_rider/logic/provider/adress_provider.dart';
import 'package:app_rider/resources/mystring.dart';
import 'package:app_rider/services/request_assistance.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';


class RequestMethods {
  static Future<String> searchCoordinatePlace(Position position,
   BuildContext context) async {
    String placeAddress = "";
    String st2, st3, st5;
    String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$google_map";
    Address currentLocation;
    var response = await RequestAssistance.getRequest(url);

    if (response != 'Failed') {
      st2 = response['results'][0]['address_components'][1]['long_name'];
      st3 = response['results'][0]['address_components'][2]['long_name'];
      st5 = response['results'][0]['address_components'][4]['long_name'];

      placeAddress = st2 + "," + st3 + "," + st5;
      currentLocation = Address();
      currentLocation.addressName = placeAddress;
      currentLocation.latitude = position.latitude;
      currentLocation.longitude = position.longitude;
      Provider.of<AddressProvider>(context, listen: false).addressPickUPLocation(currentLocation);
    }

    return placeAddress;
  }
}