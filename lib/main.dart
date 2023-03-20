import 'package:flutter/services.dart';
import 'package:women_safety_flutter/services/local_services.dart';

import 'pages/screens.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
  ).then((_){
    runApp(const MyApp());
  });

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Women Safety',
      debugShowCheckedModeBanner: false,
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
      home: const Splash(),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch(state){
      case AppLifecycleState.resumed:
        LocalService().getXmppConnection();
        debugPrint('Application Resumed');
        break;
      case AppLifecycleState.detached:
        LocalService().logoutXMPP();
        debugPrint('Application Detached');
    }
  }
}
