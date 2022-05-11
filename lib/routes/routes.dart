import 'package:app_rider/screen/authscreen/login_page.dart';
import 'package:app_rider/screen/authscreen/signup_page.dart';
import 'package:app_rider/screen/mainpage.dart';
import 'package:app_rider/screen/search_screen.dart';

class AppRoutes {


  static final routes = {
    Routes.loginScreen:(_)=>LoginPage(),
    Routes.singUpScreen:(_)=>SignUP(),
    Routes.mainScreen:(_)=> const MainPage(),
    Routes.searchScreen:(_)=> SearchScreen(),

  };
}

class Routes {
  static const String loginScreen = '/login_Screen';
  static const String singUpScreen = '/singUp_Screen';
  static const String mainScreen = '/main_Screen';
  static const String searchScreen = '/search_Screen';

}