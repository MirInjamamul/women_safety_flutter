import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';


class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<AppContact>? _contacts;
  bool _permissionDenied = false;


  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }


  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);
    } else {


      // final contacts = await FlutterContacts.getContacts();
      // setState(() => _contacts = contacts);

      getAllContacts();
      // if(_contacts!.isNotEmpty){
      //   for(var i = 0; i<_contacts!.length; i++){
      //     final fullNumber = await FlutterContacts.getContact(_contacts![i].id);
      //     _numList.add(fullNumber!.phones.first.number);
      //   }
      // }
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
    return Column( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
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
            const Text('Contact', style: TextStyle(color: Colors.black, fontSize: 16)),
            const Expanded(child: SizedBox()),
            const SizedBox()
          ],),
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
                    leading: ContactAvatar( Key('$i'),_contacts![i], 36),
                    title: Text(_contacts![i].info.displayName),
                    trailing: InkWell(
                      onTap: () async{
                        final fullContact = await FlutterContacts.getContact(_contacts![i].info.id);
                        _textMe(fullContact!.phones.first.number, '');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.blueAccent
                        ),
                        child: Text('Invite', style: TextStyle(color: Colors.white, fontSize: 16),),
                      ),
                    ),
                  );
                }
            ),
          ),
        ),
      ],
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
            shape: BoxShape.circle, gradient: getColorGradient(contact.color)),
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