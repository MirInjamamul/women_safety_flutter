import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:women_safety_flutter/controllers/home_controller.dart';
import 'package:women_safety_flutter/data/contact_model.dart';
import 'package:women_safety_flutter/pages/screens.dart';


class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<AppContact>? _contacts;
  bool _permissionDenied = false;
  String _number = '';
  bool  _isLoading = true;

  @override
  void initState() {
    Get.find<HomeController>().getContactList(true);
    super.initState();
    _fetchContacts();
  }


  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);
    } else {
      getAllContacts();
    }
  }

  getAllContacts() async {
    List colors = [
      Colors.green,
      Colors.indigo,
      Colors.yellow,
      Colors.orange
    ];
    int colorIndex = 0;
    List<AppContact> contacts = ( await FlutterContacts.getContacts()).map((contact) {
      Color baseColor = colors[colorIndex];
      colorIndex++;
      if (colorIndex == colors.length) {
        colorIndex = 0;
      }
      return AppContact(info: contact, color: baseColor);
    }).toList();
    setState(() => _contacts = contacts);
    // fetchNumber().then((value) => setState(() {
    //   _isLoading = false;
    // }));

  }

  Future fetchNumber()async{
    for(var item in _contacts!){
      final fullContact = await FlutterContacts.getContact(item.info.id);
      _number = fullContact!.phones.first.number;
      print('kfadngkfgfdgfdg ${_number}/${fullContact}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: SafeArea(
        child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30))
            ),
            child: _body()
        ),
      ),
    );
  }

  Widget _body() {
    if (_permissionDenied) return const Center(child: Text('Permission denied'));
    if (_contacts == null) return const Center(child: CircularProgressIndicator());

    return GetBuilder<HomeController>(
      builder: (home) => Column( crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50,
            padding: const EdgeInsets.all(12),
            child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
              const SizedBox(width: 10),
              InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTap: () => Get.back(),
                  child:  const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18,)),
              const Expanded(child: SizedBox()),
               Text('contact'.tr, style: const TextStyle(color: Colors.black, fontSize: 16)),
              const Expanded(child: SizedBox()),
              const SizedBox()
            ],),
          ),

          if(home.contactList.isNotEmpty)...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('save_contact'.tr, style: grey15RegularTextStyle.copyWith(color: Colors.black),),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: home.contactList.length,
                itemBuilder: (_, index){
                  String colorVal = '(0xFF${home.contactList[index].colors})';
                  String valueString = colorVal.split('(0x')[1].split(')')[0]; // kind of hacky..
                  int value = int.parse(valueString, radix: 16);
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color(value),
                      child: Text(home.contactList[index].name.isNotEmpty ? (home.contactList[index].name[0]).toUpperCase() : '',
                          style: const TextStyle(color: Colors.white)),
                    ),
                    title: Text(home.contactList[index].name),
                   // subtitle: Text(home.contactList[index].phone),
                  );
                }),
            if(home.contactList.length > 2)...[
              const Expanded(child: SizedBox())
            ]
          ],


          if(home.contactList.length < 3)...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('new_contact'.tr, style: grey15RegularTextStyle.copyWith(color: Colors.black),),
            ),
            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overScroll) {
                  overScroll.disallowIndicator();
                  return true;
                },
                child: ListView.builder(
                    itemCount: _contacts!.length,
                    itemBuilder: (context, i) {

                      return ListTile(
                        leading: ContactAvatar(Key('$i'),_contacts![i], 36),
                        title: Text(_contacts![i].info.displayName),
                       // subtitle: Text(_number),
                        trailing: InkWell(
                          onTap: () async{
                            final fullContact = await FlutterContacts.getContact(_contacts![i].info.id);
                            Get.find<HomeController>().contactInsert(ContactModel(name: _contacts![i].info.displayName, phone: fullContact!.phones.first.number, colors: _contacts![i].color.value.toRadixString(16).toString()));
                            Get.back();
                            // _textMe(fullContact!.phones.first.number, '');
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.blueAccent
                            ),
                            child:  Text("save".tr, style: TextStyle(color: Colors.white, fontSize: 16),),
                          ),
                        ),
                      );
                    }
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }

  _textMe(String num, String link) async {
    if (Platform.isAndroid) {
      var uri = 'sms:$num?body=$link';
      await  launchUrl(Uri.parse(uri));
    } else if (Platform.isIOS) {
      var uri = 'sms:$num&body=$link';
      await  launchUrl(Uri.parse(uri));
    }
  }
}


class AppContact {
  final Color color;
  Contact info;

  AppContact({Key? key, required this.color, required this.info});
}


class ContactAvatar extends StatelessWidget {
  const ContactAvatar(Key? key, this.contact, this.size) : super(key: key);
  final AppContact contact;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: getColorGradient(contact.color)),
        child: (contact.info.thumbnail != null && contact.info.thumbnail!.isNotEmpty)
            ? CircleAvatar(
          backgroundImage: MemoryImage(contact.info.thumbnail!),
        )
            : CircleAvatar(
            child: Text(contact.info.displayName.isNotEmpty ? (contact.info.displayName[0] + contact.info.name.last).toUpperCase() : '',
                style: const TextStyle(color: Colors.white)),
            backgroundColor: Colors.transparent));
  }
}



LinearGradient getColorGradient(Color color) {
  var baseColor = color as dynamic;
  Color color1 = baseColor[800];
  Color color2 = baseColor[400];
  return LinearGradient(colors: [
    color1,
    color2,
  ], begin: Alignment.bottomLeft, end: Alignment.topRight);
}


class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    return int.parse(hexColor, radix: 16);
  }
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}