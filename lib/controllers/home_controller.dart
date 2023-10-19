
import 'package:get/get.dart';
import 'package:women_safety_flutter/data/contact_model.dart';
import 'package:women_safety_flutter/pages/screens.dart';
import 'package:women_safety_flutter/services/database_helper.dart';
import 'package:women_safety_flutter/utils/api_config.dart';

import '../repositories/home_repo.dart';

class HomeController extends GetxController implements GetxService{
  final HomeRepo homeRepo;

  HomeController({required this.homeRepo});

  bool _isPanicSwitched = false;
  bool get isPanicSwitced => _isPanicSwitched;

  setPanicTrigger(bool value){
    _isPanicSwitched = value;
  }

  bool _isObservationSwitched = false;
  bool get isObservationSwitched => _isObservationSwitched;

  setObservationTrigger(bool value){
    _isObservationSwitched = value;
  }

  List<ContactModel> _contactList = [];
  List<ContactModel> get contactList => _contactList;

  Future<void> getContactList( bool reload) async{
    if (reload) {
      _contactList = [];
      update();
    }
     _contactList = await DatabaseHelper.instance.getContactList();
    update();
  }


  Future<void> contactInsert(ContactModel contactModel) async{
    await DatabaseHelper.instance.insertContact(contactModel);
    update();
  }

}