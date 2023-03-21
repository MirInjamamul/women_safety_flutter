import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:intl/intl.dart';
import 'package:women_safety_flutter/utils/custom_toast.dart';
class ComplainScreen extends StatefulWidget {
  const ComplainScreen({Key? key}) : super(key: key);

  @override
  State<ComplainScreen> createState() => _ComplainScreenState();
}

class _ComplainScreenState extends State<ComplainScreen> {
   List<String> list = <String>['স্থান নির্বাচন করুন','চন্দনপুর', 'নন্দনকানন', 'বন্দর', 'ইপিজেড'];
   String dropdownValue = '';

   TextEditingController _controller = TextEditingController();
   DateTime? _dateTime;
   @override
  void initState() {
    // TODO: implement initState
     dropdownValue = list.first;
    super.initState();
  }
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
          child: const Text('অভিযোগ বাক্স',  style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: SafeArea(
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
              child: InkWell(
                onTap: () async{
                  DateTime? dateTime = await getDate(context);
                 setState(() {
                   _dateTime = dateTime;
                 });
                },
                child: Row(
                  children:  [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(_dateTime != null ? dateToDateTime(_dateTime!) : 'সময় নির্বাচন করুন'),
                    ),
                    const Expanded(child: SizedBox()),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
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
                    dropdownValue = 'স্থান নির্বাচন করুন';
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
                    color: Colors.green,
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

          ],
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