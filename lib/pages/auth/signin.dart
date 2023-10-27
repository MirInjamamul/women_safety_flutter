import 'dart:ffi';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:women_safety_flutter/controllers/auth_controller.dart';
import 'package:women_safety_flutter/pages/screens.dart';

// ignore: must_be_immutable
class Signin extends StatefulWidget {
  Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  DateTime? currentBackPressTime;
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    username_controller.dispose();
    password_controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthController>(builder: (auth){
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
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text(
                  'sign_in'.tr,
                  style: white20BoldTextStyle,
                ),
              ),
              body: ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: fixPadding * 2.0),
                          padding: const EdgeInsets.symmetric(
                            horizontal: fixPadding * 2.0,
                            vertical: fixPadding * 3.5,
                          ),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              nameTextField(),
                              heightSpace,
                              heightSpace,
                              heightSpace,
                              heightSpace,
                              passwordTextField(),
                              heightSpace,
                              heightSpace,
                              heightSpace,
                              heightSpace,
                              otherOptions(context),
                              heightSpace,
                              heightSpace,
                              heightSpace,
                              heightSpace,
                              heightSpace,
                              heightSpace,
                              signinButton(context, auth),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
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

  nameTextField() {
    return Container(
      padding: const EdgeInsets.all(fixPadding * 1.2),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: greyColor.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 2,
          ),
        ],
      ),
      child: TextField(
        cursorColor: primaryColor,
        style: black15SemiBoldTextStyle,
        keyboardType: TextInputType.emailAddress,
        controller: username_controller,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          hintText: 'user_name'.tr,
          hintStyle: grey15RegularTextStyle,
          border: const UnderlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }

  passwordTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(fixPadding * 1.2),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: greyColor.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 2,
              ),
            ],
          ),
          child: TextField(
            obscureText: true,
            cursorColor: primaryColor,
            style: black15SemiBoldTextStyle,
            controller: password_controller,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              hintText: 'password'.tr,
              hintStyle: grey15RegularTextStyle,
              border: const UnderlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ),
        heightSpace,
        Text(
          'forget_password'.tr,
          style: grey12RegularTextStyle,
        ),
      ],
    );
  }

  otherOptions(context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: fixPadding / 6,
                  vertical: fixPadding * 1.5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xff4267b2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/facebook.png',
                      height: 15,
                      width: 15,
                    ),
                    Text(
                      'signIn_with_facebook'.tr,
                      style: white12BoldTextStyle,
                    ),
                  ],
                ),
              ),
            ),
            widthSpace,
            widthSpace,
            widthSpace,
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: fixPadding / 2.6,
                  vertical: fixPadding * 1.5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffea4335),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/google.png',
                      height: 15,
                      width: 15,
                    ),
                    widthSpace,
                    Text(
                      'signIn_with_google'.tr,
                      style: white12BoldTextStyle,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        heightSpace,
        heightSpace,
        heightSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'do_not_have_account'.tr,
              style: grey14SemiBoldTextStyle,
            ),
            const SizedBox(width: 5),
            InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Signup()),
                );
              } ,
              child: Text(
                'sign_up'.tr,
                style: primaryColor14SemiBoldTextStyle,
              ),
            ),
          ],
        ),
      ],
    );
  }

  signinButton(context, AuthController auth) {
    return InkWell(
      onTap: () {
        //TODO login with email and password
        checkUserLogin(auth);
      },
      child: Container(
        padding: const EdgeInsets.all(fixPadding * 1.5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          'SIGN_IN'.tr,
          style: white16BoldTextStyle,
        ),
      ),
    );
  }

  void checkUserLogin(AuthController authController) async{
    if(username_controller.text.isNotEmpty && password_controller.text.isNotEmpty){
        authController.signIn(username_controller.text, password_controller.text).then((status) {
          if(status.isSuccess!){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const BottomBar()));
          }else{
            Fluttertoast.showToast(
                msg: status.message!,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        });
    }else{
      Fluttertoast.showToast(
          msg: "write_something_in_the_box".tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
}
