
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:women_safety_flutter/controllers/complain_controller.dart';
import 'package:women_safety_flutter/helper/remote/api_client.dart';

import '../controllers/auth_controller.dart';
import '../controllers/home_controller.dart';
import '../repositories/auth_repo.dart';
import '../repositories/complain_repo.dart';
import '../repositories/home_repo.dart';
import '../utils/api_config.dart';

Future<void> init() async{

  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: ApiConfig.baseUrl, sharedPreferences: Get.find()));

//  Repository
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => ComplainRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => HomeRepo(apiClient: Get.find(), sharedPreferences: Get.find()));


  /// Controller
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => ComplainController(complainRepo: Get.find()));
  Get.lazyPut(() => HomeController(homeRepo: Get.find()));

}