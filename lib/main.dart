import 'package:app_rider/logic/provider/adress_provider.dart';
import 'package:app_rider/logic/provider/auth_provider.dart';
import 'package:app_rider/logic/provider/mainpage_peovider.dart';
import 'package:app_rider/logic/provider/price_fares.dart';
import 'package:app_rider/logic/provider/search_places.dart';
import 'package:app_rider/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'logic/provider/get_place_directions.dart';





void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp( MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthProvider>(create:(_)=>AuthProvider()),
      ChangeNotifierProvider<MainProvider>(create:(_)=>MainProvider()),
      ChangeNotifierProvider<AddressProvider>(create:(_)=>AddressProvider()),
      ChangeNotifierProvider<SearchPlaceProvider>(create:(_)=>SearchPlaceProvider()),
      ChangeNotifierProvider<GetPlaceDirection>(create:(_)=>GetPlaceDirection()),
      ChangeNotifierProvider<PriceFares>(create:(_)=>PriceFares()),

    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
   const MyApp({Key? key}) : super(key: key);
  get prefs async {
    return await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner:false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily:"Brand-Regular",
          primarySwatch: Colors.blue,
        ),
        initialRoute:FirebaseAuth.instance.currentUser!=null?Routes.mainScreen:Routes.loginScreen,
        routes:AppRoutes.routes
    );
  }


}

