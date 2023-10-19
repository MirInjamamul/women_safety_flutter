import 'package:get/get.dart';
import 'package:women_safety_flutter/constants/constants.dart';
import 'package:women_safety_flutter/controllers/auth_controller.dart';
import 'package:women_safety_flutter/controllers/localization_controller.dart';
import 'package:women_safety_flutter/pages/chat/chat.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:women_safety_flutter/utils/images.dart';

import '../auth/signin.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFE7ECEF);
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        leadingWidth: 0,
        leading: const SizedBox(),
        title: Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(-2,-4),
                  blurRadius: 1,
                  inset: false,

                ),
                BoxShadow(
                  color: Color(0xFFA7A9AF),
                  offset: Offset(2,2),
                  blurRadius: 1,
                  spreadRadius: 1,
                  inset: false,
                ),
              ]
          ),
          child: Text('profile'.tr,  style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
          ),
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
            Image.asset(Images.profile, width: 100, height: 100,),
            widthSpace,
            widthSpace,
            widthSpace,
            widthSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Get.find<AuthController>().getName(),
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
                      'upgrade_plan'.tr,
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
          title: 'chat'.tr,
          image: 'assets/icons/chat.png',
          color: blackColor,
        ),
        detail(
          // ontap: () => Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const Notifications()),
          // ),
          title: 'notification'.tr,
          image: 'assets/icons/notification.png',
          color: blackColor,
        ),
        detail(
          // ontap: () => Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const SubscriptionPaln()),
          // ),
          title: 'subscription_plan'.tr,
          image: 'assets/icons/subscribe.png',
          color: blackColor,
        ),
        detail(
          // ontap: () => Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const Settings()),
          // ),
          title: 'settings'.tr,
          image: 'assets/icons/setting.png',
          color: blackColor,
        ),
        detail(
          ontap: () {},
          title: 'terms_condition'.tr,
          image: 'assets/icons/condition.png',
          color: blackColor,
        ),

        GetBuilder<LocalizationController>(
          builder: (local) => InkWell(
            onTap: () => local.toggleLanguage(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: fixPadding * 1.2,
                horizontal: fixPadding * 2.0,
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/sort.png',
                    color: blackColor,
                    height: 20,
                    width: 20,
                    fit: BoxFit.cover,
                  ),
                  widthSpace,
                  widthSpace,
                  widthSpace,
                  widthSpace,
                  Text(
                    'language'.tr,
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    local.locale.languageCode == 'en'
                        ? 'English'.tr
                        :'Bangla'.tr,
                    style: black13RegularTextStyle,
                  ),
                 const SizedBox(width: 6),
                 const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  )
                ],
              ),
            ),
          ),
        ),

        heightSpace,
        detail(
          ontap: () => logoutDialog(context),
          title: 'logOut'.tr,
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
                      'sure_you_want_to_logout'.tr,
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
                                'cancel'.tr,
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
                           onTap: (){
                             Get.find<AuthController>().clearSharedData().then((value) {
                               Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (BuildContext context) => Signin()), (route) => false);
                             });
                             },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                'logOut'.tr,
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
