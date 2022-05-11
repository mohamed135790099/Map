import 'package:app_rider/logic/model/directions_place.dart';
import 'package:flutter/cupertino.dart';

class PriceFares extends ChangeNotifier{
 PlaceDirection? placeDirectionLocation;
 double calculateFares(PlaceDirection placeDirection){
    double timeTravelFare=(placeDirection.durationValue!/60)*0.20;
    double distanceTravelFare=(placeDirection.distanceValue!/1000);
    double totalMount;
    if(timeTravelFare>1&&timeTravelFare<=30||(distanceTravelFare>1&&distanceTravelFare<=10)){
      totalMount=distanceTravelFare*2;
    }
    else if(timeTravelFare>30&&timeTravelFare<=360||(distanceTravelFare>10&&distanceTravelFare<=50)){
      totalMount=distanceTravelFare*3;
    }
    else if(timeTravelFare>360&&timeTravelFare<=720||(distanceTravelFare>50&&distanceTravelFare<=250)){
      totalMount=distanceTravelFare*4;
    }
    else if(timeTravelFare>720&&timeTravelFare<=1260||(distanceTravelFare>250&&distanceTravelFare<=1250)){
      totalMount=distanceTravelFare*5;
    }
    else{
      totalMount=distanceTravelFare*6;
    }
    return totalMount;

  }
}