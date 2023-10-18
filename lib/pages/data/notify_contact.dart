

import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:women_safety_flutter/controllers/home_controller.dart';
import 'package:women_safety_flutter/data/contact.dart';
import 'package:women_safety_flutter/data/contact_model.dart';
import 'package:women_safety_flutter/services/database_helper.dart';
import '../screens.dart';

class NotifyContact extends StatefulWidget {
  NotifyContact({Key? key}) : super(key: key);

  @override
  State<NotifyContact> createState() => _NotifyContactState();
}

class _NotifyContactState extends State<NotifyContact> {
  DateTime? currentBackPressTime;

  final name_controller = TextEditingController();
  final phone_controller = TextEditingController();
  // final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void dispose() {
    // TODO: implement dispose
    name_controller.dispose();
    phone_controller.dispose();

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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Notify Contact',
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
                        phoneTextField(),
                        heightSpace,
                        heightSpace,
                        heightSpace,
                        heightSpace,
                        NotifyContactButton(context),
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
  }

  // onWillPop() {
  //   DateTime now = DateTime.now();
  //   if (currentBackPressTime == null ||
  //       now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
  //     currentBackPressTime = now;
  //     Fluttertoast.showToast(
  //       msg: 'Press Back Once Again to Exit.',
  //       backgroundColor: Colors.black,
  //       textColor: whiteColor,
  //     );
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

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
        controller: name_controller,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          hintText: 'Contact Name',
          hintStyle: grey15RegularTextStyle,
          border: const UnderlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }

  phoneTextField() {
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
            cursorColor: primaryColor,
            style: black15SemiBoldTextStyle,
            controller: phone_controller,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              hintText: 'Phone Number',
              hintStyle: grey15RegularTextStyle,
              border: const UnderlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ),
        heightSpace,
      ],
    );
  }

  NotifyContactButton(context) {
    return InkWell(
      onTap: () {
        //TODO login with email and password
        insert_phone_number();
      },
      child: Container(
        padding: const EdgeInsets.all(fixPadding * 1.5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          'Confirm'.toUpperCase(),
          style: white16BoldTextStyle,
        ),
      ),
    );
  }

  void insert_phone_number() async{
    // row to insert
   // Get.find<HomeController>().contactInsert(ContactModel(name: name_controller.text, phone: phone_controller.text));

    Fluttertoast.showToast(
        msg: "Phone Number Added",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );

    name_controller.text = '';
    phone_controller.text = '';
  }

}
