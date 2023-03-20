import 'package:flutter/material.dart';
import 'package:women_safety_flutter/constants/constants.dart';
import 'package:women_safety_flutter/pages/chat/chat.dart';

import '../../bottom_bar.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Profile',
          style: black20BoldTextStyle,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          userProfile(context),
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          profileDetail(context),
        ],
      ),
    );
  }

  userProfile(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: InkWell(
        // onTap: () => Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const UserProfileDetail()),
        // ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: const DecorationImage(
                  image: AssetImage('assets/users/user1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            widthSpace,
            widthSpace,
            widthSpace,
            widthSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Azhar Khan',
                  style: black16BoldTextStyle,
                ),
                Text(
                  'LV-651232',
                  style: grey14RegularTextStyle,
                ),
                Text(
                  'You\'re a subscribed user',
                  style: grey12RegularTextStyle,
                ),
                heightSpace,
                heightSpace,
                InkWell(
                  // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const UpgradePlan())),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: fixPadding * 2.0,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      border: Border.all(color: primaryColor),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'Upgrade plan',
                      style: white14SemiBoldTextStyle,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              color: greyColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  profileDetail(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // detail(
        //   ontap: () {
        //     currentIndex = 1;
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => const BottomBar()),
        //     );
        //   },
        //   title: 'Matches',
        //   image: 'assets/icons/matches.png',
        //   color: blackColor,
        // ),
        // detail(
        //   // ontap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Shortlist())),
        //   title: 'Shortlisted',
        //   image: 'assets/icons/star.png',
        //   color: blackColor,
        // ),
        // detail(
        //   // ontap: () => Navigator.push(
        //   //   context,
        //   //   MaterialPageRoute(builder: (context) => const ProfileViews()),
        //   // ),
        //   title: 'Profile Views',
        //   image: 'assets/icons/view.png',
        //   color: blackColor,
        // ),
        detail(
          ontap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Chat()),
          ),
          title: 'Chats',
          image: 'assets/icons/chat.png',
          color: blackColor,
        ),
        detail(
          // ontap: () => Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const Notifications()),
          // ),
          title: 'Notifications',
          image: 'assets/icons/notification.png',
          color: blackColor,
        ),
        detail(
          // ontap: () => Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const SubscriptionPaln()),
          // ),
          title: 'Subscription Plans',
          image: 'assets/icons/subscribe.png',
          color: blackColor,
        ),
        detail(
          // ontap: () => Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const Settings()),
          // ),
          title: 'Settings',
          image: 'assets/icons/setting.png',
          color: blackColor,
        ),
        detail(
          ontap: () {},
          title: 'Terms & Conditions',
          image: 'assets/icons/condition.png',
          color: blackColor,
        ),
        heightSpace,
        heightSpace,
        detail(
          ontap: () => logoutDialog(context),
          title: 'Logout',
          image: 'assets/icons/logout.png',
          color: primaryColor,
        ),
      ],
    );
  }

  detail({required String title, required String image, Color? color, Function? ontap}) {
    return InkWell(
      onTap: ontap as void Function()?,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: fixPadding * 1.2,
          horizontal: fixPadding * 2.0,
        ),
        child: Row(
          children: [
            Image.asset(
              image,
              color: color,
              height: 20,
              width: 20,
              fit: BoxFit.cover,
            ),
            widthSpace,
            widthSpace,
            widthSpace,
            widthSpace,
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            title == 'Logout'
                ? Container()
                : const Icon(
              Icons.arrow_forward_ios,
              size: 15,
            )
          ],
        ),
      ),
    );
  }

  logoutDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(fixPadding * 1.5),
                child: Column(
                  children: [
                    Text(
                      'Sure you want to logout?',
                    ),
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                'Cancel',
                              ),
                            ),
                          ),
                        ),
                        widthSpace,
                        widthSpace,
                        widthSpace,
                        widthSpace,
                        Expanded(
                          child: InkWell(
                            // onTap: () => Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => Signin()),
                            // ),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                'Logout',
                                style: white16BoldTextStyle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
