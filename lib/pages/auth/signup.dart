import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:women_safety_flutter/pages/screens.dart';

import '../../controllers/auth_controller.dart';

// ignore: must_be_immutable
class Signup extends StatefulWidget {

  Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();
  final email_controller = TextEditingController();
  final mobile_controller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    username_controller.dispose();
    password_controller.dispose();
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
                'Sign Up',
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
          hintText: 'Full Name',
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
          hintText: 'Email Address',
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
          hintText: 'Mobile Number',
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
          hintText: 'Password',
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
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          hintText: 'Confirm Password',
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
                      'Signup with facebook',
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
                      'Signup with Google',
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
              'Already have account? ',
              style: grey14SemiBoldTextStyle,
            ),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Signin()),
              ),
              child: Text(
                'Sign In',
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
        _checkControl();

        authController.signUp(email_controller.text, password_controller.text, username_controller.text, mobile_controller.text).then((status) {
          if(status.isSuccess!){
            debugPrint("Success");

            saveData();
            currentIndex = 0;
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const BottomBar()),
            );

          }else{
            debugPrint("Failed");
          }
        });

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
          'Sign Up'.toUpperCase(),
          style: white16BoldTextStyle,
        ),
      ),
    );
  }

  saveData() async{

      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setBool('login', true);
      prefs.setString('username', username_controller.text);
      prefs.setString('password', password_controller.text);

    }

  void _checkControl() {
  //  TODO need to check control of input fields
  }
}
