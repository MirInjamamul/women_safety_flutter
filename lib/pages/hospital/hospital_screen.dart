import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:women_safety_flutter/data/thana_model.dart';
import 'package:women_safety_flutter/utils/images.dart';


class HospitalScreen extends StatefulWidget {
  const HospitalScreen({Key? key}) : super(key: key);

  @override
  State<HospitalScreen> createState() => _HospitalScreenState();
}

class _HospitalScreenState extends State<HospitalScreen> {

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
          child: const Text('হাসপাতালের নাম্বার সমূহ:-', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
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
                        Text('বিভাগ: ${_thanaList[index].dept}', style: const TextStyle(color: Colors.black, fontSize: 12), overflow: TextOverflow.ellipsis, maxLines: 2),
                        const SizedBox(height: 5,),
                        Text('ঠিকানা: ${_thanaList[index].address}', style: const TextStyle(color: Colors.black, fontSize: 12), overflow: TextOverflow.ellipsis, maxLines: 2),
                        const SizedBox(height: 4,),
                        Text('ফোন: ${_thanaList[index].phone}', style: const TextStyle(color: Colors.black, fontSize: 12), overflow: TextOverflow.ellipsis, maxLines: 2),
                        const SizedBox(height: 4,),
                        RichText(text: TextSpan(
                          text: 'ওয়েবসাইট: ',
                          style: const TextStyle(color: Colors.black, fontSize: 12),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => launchURL(_thanaList[index].url ?? ''),
                              text: _thanaList[index].url,
                              style: const TextStyle(color: Colors.blue, fontSize: 14),
                            )
                          ]
                        ))
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
    ThanaModel(id: 0,image: Images.police, title: 'বিনএসবি', dept: 'জেনারেল হাসপাতাল',address: 'পাহাড়তলী, চট্টগ্রাম', phone: "+88031-659019",icon: 'assets/whatsapp.png', url: 'https://www.bnsb.org'),
    ThanaModel(id: 1,image: Images.police, title: 'সিএসসিআর', dept: 'জেনারেল হাসপাতাল',address: 'প্রবোর্টক সার্কেল, চট্টগ্রাম', phone: "+880312550625",icon: 'assets/whatsapp.png', url: ''),
    ThanaModel(id: 2,image: Images.police, title: 'সেন্টার পয়েন্ট হাসপাতাল প্রাইভেট লিমিটেড', dept: 'জেনারেল হাসপাতাল',address: '১০০, মমিন রোড, চট্টগ্রাম', phone: "+88 031 639025-7",icon: 'assets/whatsapp.png', url: 'https://www.centerpointhospital.in'),
    ThanaModel(id: 3,image: Images.police, title: 'চট্টগ্রাম মা-শিশু জেনারেল হাসপাতাল', dept: 'শিশু স্বাস্থ্য ও মাদার কেয়ার হাসপাতাল',address: 'আগ্রাবাদ, চট্টগ্রাম', phone: "+880-31-2520063",icon: 'assets/whatsapp.png', url: 'http://www.maa-shishu-ctg.org'),
    ThanaModel(id: 4,image: Images.police, title: 'চট্টগ্রাম আন্তর্জাতিক মেডিকেল কলেজ ও হাসপাতাল', dept: 'জেনারেল হাসপাতাল',address: '২০৬/১, হাজী চাঁদ মিয়া রোড, শমসের পাড়া চাঁদগাও, চট্টগ্রাম', phone: "+88 031-672384",icon: 'assets/whatsapp.png', url: 'https://www.cimch.edu.bd/'),

    ThanaModel(id: 5,image: Images.police, title: 'শেভরন', dept: 'জেনারেল হাসপাতাল',address: 'মক্কি মসজিদের সামনে, চট্টগ্রাম', phone: "880-31-657863",icon: 'assets/whatsapp.png', url: 'https://www.chevronlab.com'),
    ThanaModel(id: 6,image: Images.police, title: 'চট্টগ্রাম স্বাস্থ্য সেবা হাসপাতাল প্রাইভেট লিমিটেড', dept: 'জেনারেল হাসপাতাল',address: '৪,ও আর নিজাম রোড, চট্টগ্রাম', phone: "+88 031 652728",icon: 'assets/whatsapp.png', url: ''),
    ThanaModel(id: 7,image: Images.police, title: 'চট্টগ্রাম মেট্রোপলিটন হাসপাতাল প্রা লিমিটেড', dept: 'জেনারেল হাসপাতাল',address: ' ৪৮৭ / বি, ওআর নিজাম রোড, জিইসি মোর, চট্টগ্রাম', phone: "+88 031 654732",icon: 'assets/whatsapp.png', url: ''),
    ThanaModel(id: 8,image: Images.police, title: 'চট্টগ্রাম পলি ক্লিনিক প্রা লিমিটেড', dept: 'জেনারেল হাসপাতাল',address: '৩৩, পাঁচলাইশ আর / এ, চট্টগ্রাম', phone: "+88 031 650911",icon: 'assets/whatsapp.png', url: ''),
    ThanaModel(id: 9,image: Images.police, title: 'একুশে হাসপাতাল', dept: 'জেনারেল হাসপাতাল',address: 'মিরজারপুল, চট্টগ্রাম', phone: "+880-31-657629",icon: 'assets/whatsapp.png', url: ''),

  ];

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}

 launchURL(String link) async {
  final Uri url = Uri.parse(link);
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

