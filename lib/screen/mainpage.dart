import 'package:app_rider/logic/provider/adress_provider.dart';
import 'package:app_rider/logic/provider/get_place_directions.dart';
import 'package:app_rider/logic/provider/mainpage_peovider.dart';
import 'package:app_rider/routes/routes.dart';
import 'package:app_rider/widget/mainpagescreen/drawer_mainpage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../resources/brand_colors.dart';
import '../widget/mainpagescreen/container_ ride_fare.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);


  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  double rideDetailsContainerHeight=0;
  double searchContainerHeight=280;

  disPlayRiderDetailsContainer() async {
    await Provider.of<GetPlaceDirection>(context,listen:false).placeDirection(context);
    setState(() {
       rideDetailsContainerHeight=250;
       searchContainerHeight=0;
       Provider.of<MainProvider>(context,listen:false).mapBottomPadding=300;
    });
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

@override
  void initState() {
  Provider.of<MainProvider>(context,listen:false).setupPositionLocator(context);
  // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  final provider=Provider.of<MainProvider>(context,listen:false);
  Set<Marker> setMarker = {};
  Set<Circle> setCircle = {};
  Marker pickUpLocMarker = Marker(
      markerId: const MarkerId("IdPickUpMarker"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: InfoWindow(title:Provider.of<GetPlaceDirection>(context,listen:false).initialPosition!=null?Provider.of<GetPlaceDirection>(context,listen:false).initialPosition!.addressName:null, snippet: "MY Location"),
      position: Provider.of<GetPlaceDirection>(context,listen:false).pickUpPosition!=null?Provider.of<GetPlaceDirection>(context,listen:false).pickUpPosition!:const LatLng(37.42796133580664, -122.085749655962),
   );
  Marker dropOffLocMarker = Marker(
       markerId: const MarkerId("IdDropOffMarker"),
       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
       infoWindow: InfoWindow(title:Provider.of<GetPlaceDirection>(context,listen:true).finalPosition!=null?Provider.of<GetPlaceDirection>(context,listen:true).finalPosition!.addressName:null, snippet: "MY destination"),
       position: Provider.of<GetPlaceDirection>(context,listen:true).dropOffPosition!=null?Provider.of<GetPlaceDirection>(context,listen:true).dropOffPosition!:const LatLng(37.42796133580664, -122.085749655962),
     );
   setState(() {
        setMarker.add(pickUpLocMarker);
        setMarker.add(dropOffLocMarker);
   });
 Circle pickUpCircle = Circle(
                  circleId:const CircleId("IdPickUpCircle"),
                  fillColor:Colors.green,
                  radius:12,
                  center:Provider.of<GetPlaceDirection>(context,listen:false).pickUpPosition!=null?Provider.of<GetPlaceDirection>(context,listen:false).pickUpPosition!:const LatLng(37.42796133580664, -122.085749655962),
                  strokeWidth:7,
                  strokeColor:Colors.white,
   );
 Circle dropOffCircle = Circle(
       circleId:const CircleId("IdDropOffCircle"),
       fillColor:Colors.black,
       radius:12,
       center:Provider.of<GetPlaceDirection>(context,listen:true).dropOffPosition!=null?Provider.of<GetPlaceDirection>(context,listen:false).dropOffPosition!:const LatLng(37.42796133580664, -122.085749655962),
       strokeWidth:7,
       strokeColor:Colors.red,
     );

    setState(() {
         setCircle.add(pickUpCircle);
         setCircle.add(dropOffCircle);
    });


  setState(() {
    Polyline polyline = Polyline(
      polylineId: const PolylineId("PolylineID"),
      color: Colors.red,
      points:Provider.of<GetPlaceDirection>(context,listen:true).polylineCoordinates,
      width:5,
      jointType:JointType.round,
      startCap:Cap.roundCap,
      endCap:Cap.roundCap,
      geodesic: true,
    );
   Provider.of<GetPlaceDirection>(context,listen:true).ployLineSet.add(polyline);
  });


  return SafeArea(
      key:_scaffoldKey,
      child: Scaffold(
        drawer: const DrawerMainPage(),
        body: Builder(
          builder:(context)=>Stack(
            children: [
              GoogleMap(
                padding:EdgeInsets.only(bottom:provider.mapBottomPadding),
                mapType: MapType.normal,
                initialCameraPosition:provider.kGooglePlex,
                myLocationEnabled:true,
                zoomControlsEnabled:true,
                zoomGesturesEnabled:true,
                polylines:Provider.of<GetPlaceDirection>(context,listen:true).ployLineSet,
                markers:setMarker,
                circles:setCircle,
                onMapCreated: (GoogleMapController controller) async {
                  provider.controller.complete(controller);
                  provider.googleMapController=controller;
                  setState(() {
                    provider.mapBottomPadding=275;
                  });
                  provider.setupPositionLocator(context);
                },
              ),

              Positioned(
                top:45,
                left:30,
                child: InkWell(
                  onTap:(){
                    Scaffold.of(context).openDrawer();
                  },
                  child: Container(
                    decoration:BoxDecoration(
                        borderRadius:BorderRadius.circular(22),
                        color:Colors.white,
                        boxShadow:const[
                          BoxShadow(
                              color:Colors.black87,
                              blurRadius:6,
                              spreadRadius:0.5,
                              offset:Offset(0.7,0.7)
                          ),
                        ]
                    ),
                    child:const CircleAvatar(
                      child:Icon(Icons.menu,color:Colors.black,),
                      backgroundColor:Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                left:0,
                right:0,
                bottom:0,
                child: AnimatedSize(
                  curve:Curves.bounceIn,
                  duration:const Duration(milliseconds:160),
                  child: Container(
                    height:searchContainerHeight,
                    width:double.infinity,
                    decoration:const BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.only(topLeft:Radius.circular(15),topRight:Radius.circular(15)),
                      boxShadow:[
                        BoxShadow(
                            color:Colors.black45,
                            blurRadius:15,
                            spreadRadius:0.5
                        )
                      ],
                    ),
                    child:Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          const Text('nice to see You',style:TextStyle(color:Colors.grey,fontSize:12),textAlign:TextAlign.center,),
                          const Text('Where are you going?',style:TextStyle(color:Colors.black,fontSize:18,fontFamily:"Brand-Bold"),),
                          const SizedBox(height:20,),
                          GestureDetector(
                            onTap:() async {
                             var res=await Navigator.of(context).pushNamed(Routes.searchScreen);
                             if(res=="obtainDirection"){
                               await disPlayRiderDetailsContainer();
                             }
                            },
                            child: Container(
                              decoration:const BoxDecoration(
                                color:Colors.white,
                                borderRadius:BorderRadius.only(topLeft:Radius.circular(4),topRight:Radius.circular(4),bottomRight:Radius.circular(4),bottomLeft:Radius.circular(4)),
                                boxShadow:[
                                  BoxShadow(
                                      color:Colors.black,
                                      blurRadius:4,
                                      spreadRadius:0.5
                                  )
                                ],
                              ),
                              child:Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children:const[
                                    Icon(Icons.search,color:Colors.blue,),
                                    SizedBox(height:5,),
                                    Text('search destination',style:TextStyle(fontSize:14,color:Colors.black),)
                                  ],
                                ),
                              ),

                            ),
                          ),
                          const SizedBox(height:10,),
                          const Divider(height:1,thickness:1,color:Colors.grey,),
                          const SizedBox(height:16,),

                          Row(
                            children: [
                              const Icon(Icons.home_outlined,color:BrandColors.colorDimText,),
                              const SizedBox(width:12,),
                              Column(
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children:[
                                   Text(Provider.of<AddressProvider>(context,listen:false).userPickupAddress!=null?Provider.of<AddressProvider>(context,listen:false).userPickupAddress!.addressName!.toString():"Add Home"),
                                   const SizedBox(height:3,),
                                   const Text('your residential address',style:TextStyle(fontSize:11,color:BrandColors.colorDimText),),
                                ],
                              )

                            ],
                          ),
                          const SizedBox(height:10,),
                          const Divider(height:1,thickness:1,color:Colors.grey,),
                          const SizedBox(height:16,),

                          Row(
                            children: [
                              const Icon(Icons.work_outline,color:BrandColors.colorDimText,),
                              const SizedBox(width:12,),
                              Column(
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children:const[
                                  Text('Add Work'),
                                  SizedBox(height:3,),
                                  Text('your office address',style:TextStyle(fontSize:11,color:BrandColors.colorDimText),),
                                ],
                              )

                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              ContainerRiderFare(riderFareContainer:rideDetailsContainerHeight,),
            ],
          ),
        ),
      ),
    );

  }

}
