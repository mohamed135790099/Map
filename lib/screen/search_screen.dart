import 'package:app_rider/logic/provider/search_places.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../logic/provider/adress_provider.dart';
import '../widget/searchScreen/prediction_list_view.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);
   final TextEditingController dropOff=TextEditingController();
   final TextEditingController? currentLocation=TextEditingController();


  @override
  Widget build(BuildContext context) {
   currentLocation!.text=Provider.of<AddressProvider>(context,listen:false).userPickupAddress!.addressName!;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black87,
                    blurRadius: 6,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7),
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height:30,),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap:(){
                          Navigator.of(context).pop();
                        },
                        child:const Icon(
                          Icons.arrow_back,
                          size: 20,
                          color: Colors.black87,
                        ),
                      ),
                      const Expanded(child: Text("Set Drop Off",style:TextStyle(color:Colors.grey,fontSize:16,fontFamily:"Brand-Bold"),textAlign:TextAlign.center,)),
                    ],
                  ),
                  const SizedBox(height:20,),
                  Row(
                    children: [
                      Image.asset("assets/images/pickicon.png",width:16,height:16,),
                      const SizedBox(width:10,),
                      Expanded(
                        child: TextField(
                          controller:currentLocation,
                          decoration:InputDecoration(
                            fillColor:Colors.white10,
                            filled:true,
                            hintText:"where are you",
                            hintStyle:const TextStyle(fontSize:14,fontWeight:FontWeight.w500,color:Colors.black45),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color:Colors.grey,
                              ),
                              borderRadius:BorderRadius.circular(5),
                            ),
                            focusedBorder:OutlineInputBorder(
                              borderSide: const BorderSide(
                                color:Colors.grey,
                              ),
                              borderRadius:BorderRadius.circular(5),
                            ),
                            errorBorder:OutlineInputBorder(
                              borderSide:const BorderSide(
                                color:Colors.red,
                              ),
                              borderRadius:BorderRadius.circular(5),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                color:Colors.red,
                              ),
                              borderRadius:BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height:20,),
                  Row(
                    children: [
                      Image.asset("assets/images/redmarker.png",width:16,height:16,),
                      const SizedBox(width:10,),
                      Expanded(
                        child: TextField(
                          controller:dropOff,
                          onChanged:(value){
                            Provider.of<SearchPlaceProvider>(context,listen:false).findPlace(value);
                          },
                          decoration:InputDecoration(
                            fillColor:Colors.white10,
                            filled:true,
                            hintText:"where to?",
                            hintStyle:const TextStyle(fontSize:14,fontWeight:FontWeight.w500,color:Colors.black45),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color:Colors.grey,
                              ),
                              borderRadius:BorderRadius.circular(5),
                            ),
                            focusedBorder:OutlineInputBorder(
                              borderSide: const BorderSide(
                                color:Colors.grey,
                              ),
                              borderRadius:BorderRadius.circular(5),
                            ),
                            errorBorder:OutlineInputBorder(
                              borderSide:const BorderSide(
                                color:Colors.red,
                              ),
                              borderRadius:BorderRadius.circular(5),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                color:Colors.red,
                              ),
                              borderRadius:BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
         const Expanded(child: PredictionListView()),
        ],
      ),
    );
  }
}
