import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:women_safety_flutter/api_client.dart';
import 'package:women_safety_flutter/controller/signalR_controller.dart';
import 'package:women_safety_flutter/data/repo/signalR_repo.dart';
import 'package:women_safety_flutter/utils/api_config.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  // Get.lazyPut(() => NetworkInfo(Get.find()));
  Get.lazyPut(() => ApiClient(appBaseUrl: ApiConfig.baseUrl, sharedPreferences: Get.find()));

  /// Repository
  Get.lazyPut(() => SignalRepo(sharedPreferences: Get.find(),apiClient: Get.find()));

  /// Controller
  Get.lazyPut(() => SignalRController(signalRepo: Get.find()));
}
