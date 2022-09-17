import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:women_safety_flutter/pages/chat/chat.dart';
import 'package:women_safety_flutter/pages/screens.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

int currentIndex = 0;

class _BottomBarState extends State<BottomBar> {
  DateTime? currentBackPressTime;

  changeIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          bool backStatus = onWillPop();
          if (backStatus) {
            exit(0);
          }
          return false;
        },
        child: (currentIndex == 0)
            ? const Home()
            : (currentIndex == 1)
            ? const Home()
            : (currentIndex == 2)
            ? const Home()
            : (currentIndex == 3)
            ? const Home()
            : const Chat(),
      ),
      bottomNavigationBar: Container(
        height: 55.0,
        alignment: Alignment.center,
        child: BottomAppBar(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getBottomBarItemTile(0, 'assets/icons/setting.png', 'Setting'),
              getBottomBarItemTile(1, 'assets/icons/home.png', 'Home'),
              getBottomBarItemTile(2, 'assets/icons/search.png', 'Notification'),
              getBottomBarItemTile(3, 'assets/icons/profile.png', 'Profile'),
              getBottomBarItemTile(4, 'assets/icons/chat.png', 'Chat'),
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

  getBottomBarItemTile(int index, String icon, String title) {
    return InkWell(
      focusColor: primaryColor,
      onTap: () {
        changeIndex(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            height: 22,
            width: 22,
            color: (currentIndex == index) ? primaryColor : greyColor,
          ),
          Text(
            title,
            style: TextStyle(
              color: (currentIndex == index) ? primaryColor : greyColor,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
