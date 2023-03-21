import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:images_picker/images_picker.dart';
import 'package:intl/intl.dart';
import 'package:women_safety_flutter/utils/custom_toast.dart';

class ComplainScreen extends StatefulWidget {
  const ComplainScreen({Key? key}) : super(key: key);

  @override
  State<ComplainScreen> createState() => _ComplainScreenState();
}

class _ComplainScreenState extends State<ComplainScreen> {
     List<String> list = <String>['থানা নির্বাচন করুন','চকবাজার থানা', 'কোতয়ালী থানা', 'ইপিজেড থানা', 'পাহাড়তলী থানা', 'বায়েজিদ বোস্তামী থানা'];
     List<String> list1 = <String>['অভিযোগের ধরণ','খুন', 'দুর্নীতি', 'ছিনতাই', 'ধর্ষণ'];
     String dropdownValue = '';
     String dropdownValue1 = '';

   final TextEditingController _controller = TextEditingController();

  // String? _imagePath;

     final List<String?> _imageList = [];

     void setImage(String? image) {
       _imageList.add(image!);
       setState(() {});
     }

     void removeImage(int index) {
       _imageList.removeAt(index);
      setState(() {});
     }

     imagePick() async{
       List<Media>? res = await ImagesPicker.pick(
         count: 3,
         pickType: PickType.all,
         language: Language.System,
         maxTime: 30,
         cropOpt: CropOption(
           cropType: CropType.rect,
         ),
       );
       if (res != null) {
         for(int index = 0; index < res.length; index++){
           setState(() {
             setImage(res[index].thumbPath);
           });
         }
       }
     }

   @override
  void initState() {
    // TODO: implement initState
     dropdownValue = list.first;
     dropdownValue1 = list1.first;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFE7ECEF);
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;
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
          child: const Text('অভিযোগ বাক্স',  style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column( crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40,),
              const Text('আপনার স্বাধীনভাবে আপনার মতামত প্রকাশ করুন', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
              const SizedBox(height: 40,),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                padding: const EdgeInsets.fromLTRB(0,4,8,4),
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
                child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.horizontal(right: Radius.circular(5)),
                        color: Colors.transparent
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        value: dropdownValue,
                        items: list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        isDense: false,
                        buttonPadding: const EdgeInsets.only(left: 16, right: 0),
                        buttonElevation: 2,
                        itemHeight: 40,
                        itemPadding: const EdgeInsets.only(left: 14, right: 14),
                        dropdownPadding: null,
                        dropdownElevation: 2,
                        scrollbarRadius: const Radius.circular(40),
                        scrollbarThickness: 6,
                        scrollbarAlwaysShow: true,
                        offset: const Offset(0, 0),
                      ),
                    )
                ),
              ),
              const SizedBox(height: 40,),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                padding: const EdgeInsets.fromLTRB(0,4,8,4),
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
                child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.horizontal(right: Radius.circular(5)),
                        color: Colors.transparent
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        value: dropdownValue1,
                        items: list1.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownValue1 = value!;
                          });
                        },
                        isDense: false,
                        buttonPadding: const EdgeInsets.only(left: 16, right: 0),
                        buttonElevation: 2,
                        itemHeight: 40,
                        itemPadding: const EdgeInsets.only(left: 14, right: 14),
                        dropdownPadding: null,
                        dropdownElevation: 2,
                        scrollbarRadius: const Radius.circular(40),
                        scrollbarThickness: 6,
                        scrollbarAlwaysShow: true,
                        offset: const Offset(0, 0),
                      ),
                    )
                ),
              ),

              const SizedBox(height: 20,),
              (_imageList.isNotEmpty) ? GridView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 15, right: 12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 30,
                    childAspectRatio: 1
                ),

                children: _imageList.map((e) {
                  int index = _imageList.indexOf(e);
                  return Container(
                    key: Key('a$index'),
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(borderRadius: BorderRadius.circular(5),
                          child: Image.file(
                              File(_imageList[index]!),
                              height: double.infinity,
                              width: double.infinity,
                              fit: BoxFit.cover),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            height: 22,
                            width: 22,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black),
                            child: InkWell(
                              onTap: () => removeImage(index),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ) : const SizedBox(),

              const SizedBox(height: 20,),
              Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () => imagePick(),
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: bg,
                            borderRadius: BorderRadius.circular(12),
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
                      child: Row(
                        children: const [
                          Icon(Icons.camera_alt),
                          SizedBox(width: 4,),
                          Text('ক্যামেরা')
                        ],
                      )
                    ),
                  ),
                  InkWell(
                    onTap: () => imagePick(),
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: bg,
                            borderRadius: BorderRadius.circular(12),
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
                        child: Row(
                          children: const [
                            Icon(Icons.videocam_off_sharp),
                            SizedBox(width: 4,),
                            Text('ভিডিও')
                          ],
                        )
                    ),
                  ),
                  InkWell(
                    onTap: () => imagePick(),
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: bg,
                            borderRadius: BorderRadius.circular(12),
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
                        child: Row(
                          children: const [
                            Icon(Icons.video_file_outlined),
                            SizedBox(width: 4,),
                            Text('ডকুমেন্ট')
                          ],
                        )
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40,),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                child: TextField(
                  controller: _controller,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'মন্তব্য লিখুন',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(5, 5, 5,0)
                  ),
                ),
              ),

              const SizedBox(height: 40,),
              InkWell(
                onTap: (){
                  setState(() {
                    if(_controller.text.isNotEmpty){
                      _controller.clear();
                      // dropdownValue = 'স্থান নির্বাচন করুন';
                      // dropdownValue1 = 'অভিযোগের ধরণ';
                      _imageList.clear();
                      showCustomToast('সফলভাবে জমা করা হয়েছে');
                    }else{
                      showCustomToast('কিছু লিখুন');
                    }
                  });

                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 18),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0xff003d00),
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
                  child: const Text('সাবমিট', style: TextStyle(color: Colors.white),),
                ),
              ),
              const SizedBox(height: 40,),
            ],
          ),
        ),
      ),
    );
  }

   Future<DateTime?> getDate(BuildContext context) {
     return showDatePicker(
       context: context,
       initialDate: DateTime.now(),
       firstDate: DateTime(1900),
       lastDate: DateTime(2030),
       builder: (BuildContext context, Widget? child) {
         return Theme(
           data: ThemeData(
             colorScheme: const ColorScheme.light(
               primary: Colors.black,
             ),
             dialogBackgroundColor: Colors.white,
           ),
           child: child!,
         );
       },
     );
   }

   String dateToDateTime(DateTime dateTime) {
     return DateFormat('MMM dd, yyyy').format(dateTime);
   }
}