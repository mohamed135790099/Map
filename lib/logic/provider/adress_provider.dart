import 'package:app_rider/logic/model/address_model.dart';
import 'package:flutter/cupertino.dart';

class AddressProvider extends ChangeNotifier{
  Address? userPickupAddress,userDropOffAddress;
  String? addressName;
  void addressPickUPLocation(Address userAddress)async{
     userPickupAddress= userAddress;
     notifyListeners();
  }

  void addressDropOffLocation(Address userAddress)async{
    userDropOffAddress= userAddress;
    notifyListeners();
  }
}