import 'package:get/get.dart';
import 'package:women_safety_flutter/pages/screens.dart';

class MyRouteHelper {
  static const String splashScreen = '/splash';
 // static const String home = '/home';
  static const String onBoarding = '/onBoarding';
 // static const String dashboard = '/';
  static const String successfulScreen = '/successful';
  static const String productDetails = '/product-branch';
  static const String searchResult = '/search-result';
  static const String searchScreen = '/search';
  static const String notification = '/notification';
  static const String favourite = '/favourite';

  static String getSplashRoute() => splashScreen;

  static String getOnBoardingRoute() => onBoarding;

  //static String getMainRoute() => dashboard;

 // static String getHomeRoute() => home;


  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const Splash()),
    GetPage(name: onBoarding, page: () => Container()),
   // GetPage(name: dashboard, page: () => const BottomBar()),
   // GetPage(name: home, page: () => const Home()),
  ];
}
