
import 'package:app_rider/logic/provider/get_place_directions.dart';
import 'package:app_rider/logic/provider/price_fares.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContainerRiderFare extends StatelessWidget {
  final double riderFareContainer;
  const ContainerRiderFare({Key? key,required this.riderFareContainer}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Positioned(
      left:0,
      right:0,
      bottom:0,
      child: AnimatedSize(
        curve:Curves.bounceIn,
        duration:const Duration(milliseconds:160),
        child: Container(
          height:riderFareContainer,
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

          child:Column(
            children: [
              Container(
                height:60,
                width:double.infinity,
                color:Colors.green,
                child: Padding(
                  padding:const EdgeInsets.symmetric(horizontal:15,vertical:10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/images/taxi.png',width:50,height:50,),
                      const SizedBox(width:20,),
                      Column(
                        children: const[
                          Text('Price',style:TextStyle(fontSize:15,fontWeight:FontWeight.bold,color:Colors.white),),
                          SizedBox(height:5,),
                          Text('150\$',style:TextStyle(fontSize:12,fontWeight:FontWeight.bold,color:Colors.white),),
                        ],
                      ),
                      const SizedBox(width:20,),
                      Column(
                        children: const[
                          Text('Car',style:TextStyle(fontSize:15,fontWeight:FontWeight.bold,color:Colors.white),),
                          SizedBox(height:5,),
                          Text('120 Km/h',style:TextStyle(fontSize:12,fontWeight:FontWeight.bold,color:Colors.white),),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
              Container(
                height:60,
                color:Colors.black,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:15),
                  child: Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(onPressed:(){}, child: Row(
                        children:const[
                          Icon(Icons.money,color:Colors.white,size:30,),
                          SizedBox(width:5,),
                          Text('Cash',style:TextStyle(fontSize:15,fontWeight:FontWeight.bold,color:Colors.white),)
                        ],)),
                      const SizedBox(width:20,),
                      const Text('OR',style:TextStyle(fontSize:15,fontWeight:FontWeight.bold,color:Colors.white),),
                      const SizedBox(width:20,),
                      TextButton(onPressed:(){}, child: Row(
                        children:const[
                          Icon(Icons.paypal,color:Colors.white,size:30,),
                          SizedBox(width:5,),
                          Text('PayPal',style:TextStyle(fontSize:15,fontWeight:FontWeight.bold,color:Colors.white),)
                        ],)),


                    ],
                  ),
                ),
              ),
              const SizedBox(height:10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:20,vertical:20),
                child: ElevatedButton(
                    onPressed:(){},
                    style:ElevatedButton.styleFrom(
                        primary:Colors.red,
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(20),
                        )
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        const SizedBox(
                            height: 50,
                            child: Center(
                              child: Text('Request',
                                style: TextStyle(
                                  fontWeight:FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            )),
                        const SizedBox(width:10,),
                        Image.asset('assets/images/taxi.png',width:50,height:50,),

                      ],)),
              ),

            ],
          ),
        ),
      ),
    );

  }
}
