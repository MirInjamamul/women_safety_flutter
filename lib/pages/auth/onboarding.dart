import 'dart:async';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:women_safety_flutter/pages/screens.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final pageViewController = PageController(initialPage: 0);
  int currentPage = 0;
  DateTime? currentBackPressTime;

  @override
  void initState() {
    super.initState();
    Timer.periodic(
      const Duration(seconds: 5),
          (Timer time) {
        if (currentPage == 0) {
          currentPage = 1;
        } else {
          currentPage = 0;
        }
        pageViewController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageViewController.dispose();
  }

  onChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: primaryColor,
        image: DecorationImage(
          image: AssetImage('assets/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
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
            children: [
              Expanded(
                child: PageView(
                  controller: pageViewController,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: onChanged,
                  children: [
                    page1(),
                    page2(),
                  ],
                ),
              ),
              nextButton(),
            ],
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

  nextButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        fixPadding * 2.0,
        0,
        fixPadding * 2.0,
        fixPadding * 2.0,
      ),
      child: currentPage == 0
          ? Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Signin()),
              );
            },
            child: Text(
              'Skip',
              style: white14SemiBoldTextStyle,
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                currentPage = 1;
              });
              pageViewController.animateToPage(
                currentPage,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: Container(
              padding: const EdgeInsets.all(fixPadding),
              decoration: const BoxDecoration(
                color: whiteColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward,
                color: primaryColor,
              ),
            ),
          ),
        ],
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () async {

              bool loggedIn = await loggedAuthFetch();

              if(loggedIn){
                currentIndex = 0;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BottomBar()),
                );
              }else{
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Signin()),
                );
              }


            },
            child: Container(
              padding: const EdgeInsets.all(fixPadding),
              decoration: const BoxDecoration(
                color: whiteColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  page1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/logo.png',
          height: 100,
          width: 110,
        ),
        heightSpace,
        Text(
          'Women Safety AID',
          style: white18SemiBoldTextStyle,
        ),
        heightSpace,
        Text(
          'Search your safety measure\nusing customized or predefined\nsupports',
          textAlign: TextAlign.center,
          style: white13RegularTextStyle,
        ),
      ],
    );
  }

  page2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/logo.png',
          height: 100,
          width: 110,
        ),
        heightSpace,
        Text(
          'Many Culture Many Religion',
          style: white18SemiBoldTextStyle,
        ),
        heightSpace,
        Text(
          'Find the prefect safety measure\nwith us',
          textAlign: TextAlign.center,
          style: white13RegularTextStyle,
        ),
      ],
    );
  }

  Future<bool> loggedAuthFetch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool('login') ?? false;
  }
}
