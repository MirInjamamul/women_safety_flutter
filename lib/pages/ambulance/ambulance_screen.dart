import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:women_safety_flutter/data/thana_model.dart';
import 'package:women_safety_flutter/utils/images.dart';


class AmbulanceScreen extends StatefulWidget {
  const AmbulanceScreen({Key? key}) : super(key: key);

  @override
  State<AmbulanceScreen> createState() => _AmbulanceScreenState();
}

class _AmbulanceScreenState extends State<AmbulanceScreen> {

  final bool _isPress = true;

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFE7ECEF);
    Offset distance = const Offset(3, 3);
    double _blur = 4.0;
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
          child: const Text('অ্যাম্বুলেন্স সমূহ:-',  style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.fromLTRB(6, 20, 6, 10),
          itemCount: _thanaList.length,
          itemBuilder: (_, index){
            return Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        offset: -distance,
                        blurRadius: _blur,
                        inset: _isPress,

                      ),
                      BoxShadow(
                        color: const Color(0xFFA7A9AF),
                        offset: distance,
                        blurRadius: _blur,
                        spreadRadius: 1,
                        inset: _isPress,
                      ),
                    ]
                ),
                child: Row( mainAxisSize: MainAxisSize.min,
                  children: [

                    Image.asset(_thanaList[index].image ?? '', height: 30,),
                    const SizedBox(width: 12,),
                    Expanded(child: Column( crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_thanaList[index].title ?? '', style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis, maxLines: 1,),
                        const SizedBox(height: 5,),
                        Text(_thanaList[index].email ?? '', style: const TextStyle(color: Colors.black, fontSize: 12), overflow: TextOverflow.ellipsis, maxLines: 2,),
                        const SizedBox(height: 4,),
                        Text(_thanaList[index].phone ?? '', style: const TextStyle(color: Colors.pink, fontSize: 14), overflow: TextOverflow.ellipsis, maxLines: 2,),
                      ],
                    )),
                    const SizedBox(width: 5,),
                    InkWell(
                      onTap: ()=> _makePhoneCall(_thanaList[index].phone ?? '0'),
                      child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.cyan,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade400,
                                    offset: const Offset(3,3),
                                    blurRadius: 10,
                                    spreadRadius: 1
                                ),
                                const BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(-6,-6),
                                    blurRadius: 10,
                                    spreadRadius: 1
                                ),
                              ]
                          ),
                          child: Image.asset(Images.call, height: 20, color: Colors.white,)),
                    ),

                  ],
                )
            );
          }),
    );
  }

  final List<ThanaModel> _thanaList =[
    ThanaModel(id: 0,image: Images.ambulance, title: 'মেডিকেল সেন্টার হাসপাতাল', email: 'spchittagong@police.gov.bd', phone: "01713998222",icon: 'assets/whatsapp.png'),
    ThanaModel(id: 1,image: Images.ambulance, title: 'মা ও শিশু হাসপাতাল অ্যাম্বুলেন্স সার্ভিস।', email: 'spchittagong@police.gov.bd', phone: "01733786629",icon: 'assets/whatsapp.png'),
    ThanaModel(id: 2,image: Images.ambulance, title: 'আগ্রাবাদ মা ও শিশু হাসপাতাল চট্টগ্রাম', email: 'Sudiptorony@gmail.com', phone: "01884959116",icon: 'assets/whatsapp.png'),
    ThanaModel(id: 3,image: Images.ambulance, title: 'সালমা অ্যাম্বুলেন্স চট্টগ্রাম', email: 'dsbchittagong@police.gov.bd', phone: "01820319992",icon: 'assets/whatsapp.png'),
    ThanaModel(id: 4,image: Images.ambulance, title: 'আলিফ অ্যাম্বুলেন্স সার্ভিস', email: 'dsbchittagong@police.gov.bd', phone: "01819380000",icon: 'assets/whatsapp.png'),
    ThanaModel(id: 5,image: Images.ambulance, title: 'চট্রগ্রাম আলফা অ্যাম্বুলেন্স সার্ভিস', email: 'dsbchittagong@police.gov.bd', phone: "01819371919",icon: 'assets/whatsapp.png'),
    ThanaModel(id: 6,image: Images.ambulance, title: 'চট্টগ্রাম মানবিক অ্যাম্বুলেন্স সার্ভিস', email: 'dsbchittagong@police.gov.bd', phone: "01881005635",icon: 'assets/whatsapp.png'),
    ThanaModel(id: 7,image: Images.ambulance, title: 'Ambulance service GEC more Chottogram', email: 'dsbchittagong@police.gov.bd', phone: "01707998822",icon: 'assets/whatsapp.png'),
    ThanaModel(id: 8,image: Images.ambulance, title: 'Habib Ambulance Agrabad', email: 'dsbchittagong@police.gov.bd', phone: "01757949128",icon: 'assets/whatsapp.png'),
    ThanaModel(id: 9,image: Images.ambulance, title: 'Saddam Ambulance service Chittagong', email: 'dsbchittagong@police.gov.bd', phone: "01305983465",icon: 'assets/whatsapp.png'),
    ThanaModel(id: 10,image: Images.ambulance, title: 'S,S Khaled Road, Kazir Dewri Chottogram', email: 'dsbchittagong@police.gov.bd', phone: "01819374920",icon: 'assets/whatsapp.png'),
  ];

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
