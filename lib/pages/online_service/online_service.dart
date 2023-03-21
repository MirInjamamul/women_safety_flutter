import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_safety_flutter/pages/ambulance/ambulance_screen.dart';
import 'package:women_safety_flutter/pages/complain/complain_screen.dart';
import 'package:women_safety_flutter/pages/emergencyService/emergency_service.dart';
import 'package:women_safety_flutter/pages/fire_service/fire_service_screen.dart';
import 'package:women_safety_flutter/pages/thana/thana_screen.dart';
import 'package:women_safety_flutter/utils/custom_toast.dart';
import 'package:women_safety_flutter/utils/images.dart';

class OnlineServiceScreen extends StatefulWidget {
  const OnlineServiceScreen({Key? key}) : super(key: key);

  @override
  State<OnlineServiceScreen> createState() => _OnlineServiceScreenState();
}

class _OnlineServiceScreenState extends State<OnlineServiceScreen> {


  final List<String> _iconList = [Images.fireService,Images.ambulance, Images.police, Images.emergencyService, Images.complain, Images.eSeva];
  final List<String> _titleList = ["ফায়ার সার্ভিস","অ্যাম্বুলেন্স", "থানা পুলিশ","জরুরী সেবা", "অভিযোগ", "ই-পরিষেবা"];

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFE7ECEF);
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        centerTitle: true,
        leading: const SizedBox(),
        title: const Text('Online Service', style: TextStyle(color: Colors.black),),
      ),
      body: SafeArea(
        child: Column(
          children: [

            Center(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset('assets/logo_main.png', height: 100, width: double.infinity-10, fit: BoxFit.cover,)),
            )),

            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                  ),
                  itemCount: 6,
                  itemBuilder: (_, index){
                    return InkWell(
                      onTap: (){
                        switch(index){
                          case 0:
                            Get.to(_screenList[index]);
                            break;
                          case 1:
                            Get.to(_screenList[index]);
                            break;
                          case 2:
                            Get.to(_screenList[index]);
                            break;
                          case 3:
                            Get.to(_screenList[index]);
                            break;
                          case 4:
                            Get.to(_screenList[index]);
                            break;
                          case 5:
                            showCustomToast('Coming soon...');
                            break;
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: bg,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              offset: const Offset(6,6),
                              blurRadius: 6,
                              spreadRadius: 1
                            ),
                            const BoxShadow(
                                color: Colors.white,
                                offset: Offset(-6,-6),
                                blurRadius: 3,
                                spreadRadius: 1
                            ),
                          ]
                        ),
                        child: Column( mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(_iconList[index], height: 30,),
                            const SizedBox(height: 8,),
                            Text(_titleList[index], style: const TextStyle(color: Colors.black, fontSize: 12), overflow: TextOverflow.ellipsis, maxLines: 2,),
                          ],
                        )
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
  final List<Widget> _screenList = [
    /// for fire service
    const FireServiceScreen(),
    /// for ambulance
    const AmbulanceScreen(),
    /// for blood
    const ThanaScreen(),
    /// for hospital
    const EmergencyServiceScreen(),
    /// for thana
    const ComplainScreen(),
    /// for e-service
    Container(color: Colors.green,),
  ];
}
