
import 'package:get/get.dart';
import 'package:women_safety_flutter/pages/screens.dart';

import '../repositories/home_repo.dart';

class HomeController extends GetxController{
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

}