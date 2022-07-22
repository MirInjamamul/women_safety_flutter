import 'dart:ffi';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
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
              'Sign In',
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
                          signinButton(context),
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
        controller: username_controller,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          hintText: 'User Name',
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
              hintText: 'Password',
              hintStyle: grey15RegularTextStyle,
              border: const UnderlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ),
        heightSpace,
        Text(
          'Forget password?',
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
                      'SignIn with facebook',
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
                      'SignIn with Google',
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
              'Don\'t have account? ',
              style: grey14SemiBoldTextStyle,
            ),
            InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Signup()),
                );
              } ,
              child: Text(
                'Sign Up',
                style: primaryColor14SemiBoldTextStyle,
              ),
            ),
          ],
        ),
      ],
    );
  }

  signinButton(context) {
    return InkWell(
      onTap: () {
        //TODO login with email and password
        checkUserLogin();
      },
      child: Container(
        padding: const EdgeInsets.all(fixPadding * 1.5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          'Sign In'.toUpperCase(),
          style: white16BoldTextStyle,
        ),
      ),
    );
  }

  void checkUserLogin() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.getString('username')!.contains(username_controller.text) && prefs.getString('password')!.contains(password_controller.text)){
      Fluttertoast.showToast(
          msg: "Login Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );

      currentIndex = 0;

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BottomBar()),
      );

    }else{
      Fluttertoast.showToast(
          msg: "Wrong Username and Password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
}
