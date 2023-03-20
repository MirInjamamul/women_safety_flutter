import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:women_safety_flutter/data/thana_model.dart';
import 'package:women_safety_flutter/utils/images.dart';


class ThanaScreen extends StatefulWidget {
  const ThanaScreen({Key? key}) : super(key: key);

  @override
  State<ThanaScreen> createState() => _ThanaScreenState();
}

class _ThanaScreenState extends State<ThanaScreen> {

  bool _isPress = true;

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
            child: const Text('থানার  নাম্বার সমূহ:-', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
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
                        InkWell(
                        onTap: () async{
                          await launchUrl(Uri.parse('mailto:${_thanaList[index].email}?subject=&body='))
                              ? await launchUrl(Uri.parse('mailto:${_thanaList[index].email}?subject=&body='))
                              : throw 'Could not launch ${'mailto:${_thanaList[index].email}?subject=&body='}';
                        },
                            child: Text(_thanaList[index].email ?? '', style: const TextStyle(color: Colors.black, fontSize: 12), overflow: TextOverflow.ellipsis, maxLines: 2,)),
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
    ThanaModel(id: 0,image: Images.police, title: 'পুলিশ সুপার', email: 'spchittagong@police.gov.bd', phone: "01320107400",icon: 'assets/whatsapp.png'),
    ThanaModel(id: 1,image: Images.police, title: 'অতিরিক্ত পুলিশ সুপার (প্রশাসন ও অর্থ)', email: 'spchittagong@police.gov.bd', phone: "01320107402",icon: 'assets/whatsapp.png'),
    ThanaModel(id: 2,image: Images.police, title: 'পিপিএম	অতিরিক্ত পুলিশ সুপার (ক্রাইম এন্ড অপস্)', email: 'Sudiptorony@gmail.com', phone: "01320107403",icon: 'assets/whatsapp.png'),
    ThanaModel(id: 3,image: Images.police, title: 'অতিরিক্ত পুলিশ সুপার (ডিএসবি)', email: 'dsbchittagong@police.gov.bd', phone: "01320107404",icon: 'assets/whatsapp.png'),
    ThanaModel(id: 4,image: Images.police, title: 'অতিরিক্ত পুলিশ সুপার (ট্রাফিক)', email: 'wferoz2009@yahoo.com', phone: "01320107405",icon: 'assets/whatsapp.png'),
    ThanaModel(id: 5,image: Images.police, title: 'পুলিশ সুপার (শিল্পাঞ্চল ও ডিবি)', email: 'spchittagong@police.gov.bd', phone: "01320107406",icon: 'assets/whatsapp.png'),
    ThanaModel(id: 6,image: Images.police, title: 'অতিরিক্ত পুলিশ সুপার (সীতাকুন্ড সার্কেল)', email: 'asp.sit.chi@police.gov.bd', phone: "01320107446",icon: 'assets/whatsapp.png'),
    ThanaModel(id: 7,image: Images.police, title: 'অতিরিক্ত পুলিশ সুপার (পটিয়া সার্কেল)', email: 'tariqdipu@gmail.com', phone: "01320107456",icon: 'assets/whatsapp.png'),
    ThanaModel(id: 8,image: Images.police, title: 'পুলিশ সুপার (সাতকানিয়া সার্কেল)', email: 'satkaniacircle@gmail.com', phone: "01320107461",icon: 'assets/whatsapp.png'),
   ];

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
