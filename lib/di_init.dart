import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:women_safety_flutter/api_client.dart';
import 'package:women_safety_flutter/controllers/signalR_controller.dart';
import 'package:women_safety_flutter/controllers/auth_controller.dart';
import 'package:women_safety_flutter/controllers/complain_controller.dart';
import 'package:women_safety_flutter/controllers/home_controller.dart';
import 'package:women_safety_flutter/data/repo/signalR_repo.dart';
import 'package:women_safety_flutter/repositories/auth_repo.dart';
import 'package:women_safety_flutter/repositories/complain_repo.dart';
import 'package:women_safety_flutter/repositories/home_repo.dart';
import 'package:women_safety_flutter/utils/api_config.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: ApiConfig.baseUrl, sharedPreferences: Get.find()));

  /// Repository

  Get.lazyPut(() => SignalRepo(sharedPreferences: Get.find(),apiClient: Get.find()));
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => ComplainRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => HomeRepo(apiClient: Get.find(), sharedPreferences: Get.find()));


  /// Controller
     Get.lazyPut(() => AuthController(authRepo: Get.find()));
     Get.lazyPut(() => ComplainController(complainRepo: Get.find()));
     Get.lazyPut(() => HomeController(homeRepo: Get.find()));
     Get.lazyPut(() => SignalRController(signalRepo: Get.find()));




}
