import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:women_safety_flutter/controllers/auth_controller.dart';
import 'package:women_safety_flutter/pages/online_service/online_service.dart';
import 'package:women_safety_flutter/pages/screens.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  DateTime? currentBackPressTime;

  @override
  void initState() {
    _route();
    super.initState();

  }
  void _route() {
    Timer(const Duration(seconds: 3), () async {
      if (Get.find<AuthController>().isLoggedIn()) {
        Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (BuildContext context) => const BottomBar()), (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (BuildContext context) => Signin()), (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/Women-safety-UAE.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: blackColor.withOpacity(0.7),
        child: WillPopScope(
          onWillPop: () async {
            bool backStatus = onWillPop();
            if (backStatus) {
              exit(0);
            }
            return false;
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/logo.png',
                    height: 100,
                    width: 110,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Press Back Once Again to Exit.',
        backgroundColor: Colors.black,
        textColor: whiteColor,
      );
      return false;
    } else {
      return true;
    }
  }
}
