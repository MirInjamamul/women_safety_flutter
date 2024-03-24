import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:women_safety_flutter/controllers/localization_controller.dart';
import 'package:women_safety_flutter/route_helper.dart';
import 'package:women_safety_flutter/services/local_string.dart';
import 'di_init.dart' as di;
import 'firebase_options.dart';
import 'pages/screens.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
  Map<String, Map<String, String>> localString = await di.init();
  runApp(MyApp(localString: localString));
}

class MyApp extends StatelessWidget with WidgetsBindingObserver{
  static final navigatorKey = GlobalKey<NavigatorState>();
  final Map<String, Map<String, String>> localString;
  const MyApp({Key? key, required this.localString}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
      builder: (local) => GetMaterialApp(
        locale: local.locale,
        translations: LocaleString(localString: localString),
        fallbackLocale: const Locale('en', 'US'),
        title: 'Women Safety',
        initialRoute: MyRouteHelper.splashScreen,
        defaultTransition: Transition.topLevel,
        transitionDuration: const Duration(milliseconds: 500),
        getPages: MyRouteHelper.routes,
        navigatorKey: Get.key,
        theme: ThemeData(
          primarySwatch: Colors.brown,
          primaryColor: primaryColor,
          fontFamily: 'NunitosSans',
          appBarTheme: const AppBarTheme(
            color: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: blackColor),
          ),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch(state){
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.inactive:
        // TODO: Handle this case.
        break;
      case AppLifecycleState.paused:
        // TODO: Handle this case.
        break;
      case AppLifecycleState.hidden:
        // TODO: Handle this case.
    }
  }
}
