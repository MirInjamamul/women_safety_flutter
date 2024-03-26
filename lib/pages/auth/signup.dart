import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:women_safety_flutter/pages/screens.dart';

import '../../controllers/auth_controller.dart';


enum ValidationError{
  password,
  empty,
  none
}

// ignore: must_be_immutable
class Signup extends StatefulWidget {

  Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();
  final confirm_password_controller = TextEditingController();
  final email_controller = TextEditingController();
  final mobile_controller = TextEditingController();



  @override
  void dispose() {
    // TODO: implement dispose
    username_controller.dispose();
    password_controller.dispose();
    confirm_password_controller.dispose();
    email_controller.dispose();
    mobile_controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthController>(builder: (auth) {
        return Container(
          decoration: const BoxDecoration(
            color: primaryColor,
            image: DecorationImage(
              image: AssetImage('assets/bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              titleSpacing: 0,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: whiteColor,
                ),
              ),
              title: Text(
                'sign_up'.tr,
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
                            emailTextField(),
                            heightSpace,
                            heightSpace,
                            heightSpace,
                            heightSpace,
                            mobileNumberTextField(),
                            heightSpace,
                            heightSpace,
                            heightSpace,
                            heightSpace,
                            passwordTextField(),
                            heightSpace,
                            heightSpace,
                            heightSpace,
                            heightSpace,
                            confirmPasswordTextField(),
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
                            signupButton(context, auth),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
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
          hintText: 'full_name'.tr,
          hintStyle: grey15RegularTextStyle,
          border: const UnderlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }

  emailTextField() {
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
        keyboardType: TextInputType.emailAddress,
        cursorColor: primaryColor,
        style: black15SemiBoldTextStyle,
        controller: email_controller,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          hintText: 'email_address'.tr,
          hintStyle: grey15RegularTextStyle,
          border: const UnderlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }

  mobileNumberTextField() {
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
        keyboardType: TextInputType.phone,
        cursorColor: primaryColor,
        style: black15SemiBoldTextStyle,
        controller: mobile_controller,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          hintText: 'mobile_number'.tr,
          hintStyle: grey15RegularTextStyle,
          border: const UnderlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }

  passwordTextField() {
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
    );
  }

  confirmPasswordTextField() {
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
        obscureText: true,
        cursorColor: primaryColor,
        style: black15SemiBoldTextStyle,
        controller: confirm_password_controller,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          hintText: 'confirm_password'.tr,
          hintStyle: grey15RegularTextStyle,
          border: const UnderlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
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
                  horizontal: fixPadding / 40,
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
                  horizontal: fixPadding / 6,
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
              'already_have_account'.tr,
              style: grey14SemiBoldTextStyle,
            ),
            const SizedBox(width: 5),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Signin()),
              ),
              child: Text(
                'sign_in'.tr,
                style: primaryColor14SemiBoldTextStyle,
              ),
            ),
          ],
        ),
      ],
    );
  }



  
  signupButton(context, AuthController authController) {
    return InkWell(
      //TODO push to BottomBar
      onTap: (){
        var checkValidation = _checkControl();

        switch(checkValidation){
          case ValidationError.password:
            Fluttertoast.showToast(
                msg: "Password is not Matched",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );

            break;
          case ValidationError.empty:
            Fluttertoast.showToast(
                msg: "Enter the value in the field",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );

            break;

          case ValidationError.none:
            authController.signUp(email_controller.text, password_controller.text, username_controller.text, mobile_controller.text).then((status) {
              if(status.isSuccess!){
                debugPrint("Success");
                CollectionReference collectionReference = FirebaseFirestore.instance.collection("users");
                collectionReference.add({
                  'email': email_controller.text,
                  'fullName': username_controller.text,
                  'mobileNumber': mobile_controller.text,
                  'password': password_controller.text
                });

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
            break;

          default:
            debugPrint("Validation check Failed");
        }
      },

      // onTap: () => Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const ProfilePic()),
      // ),
      child: Container(
        padding: const EdgeInsets.all(fixPadding * 1.5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          'SIGN_UP'.tr,
          style: white16BoldTextStyle,
        ),
      ),
    );
  }

  Object _checkControl() {
  //  TODO need to check control of input fields
    if(password_controller.text != confirm_password_controller.text){
      debugPrint("***** false");
      return ValidationError.password;
    }else if(password_controller.text.isEmpty || confirm_password_controller.text.isEmpty || email_controller.text.isEmpty || username_controller.text.isEmpty || mobile_controller.text.isEmpty){
      return ValidationError.empty;
    }else {
      return ValidationError.none;
    }
  }
}
