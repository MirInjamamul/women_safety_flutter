
import 'dart:math';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:women_safety_flutter/api_client.dart';
import '../utils/api_config.dart';

class AuthRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> signUp(
      {required String email, required String password, required String username, required String mobile}) async {
    return await apiClient.postData(ApiConfig.signUpUri, {
      "name": username,
      "email": email,
      "mobile": mobile,
      "password": password
    });
  }

  Future<Response> signIn(
      {required String email}) async {
    return await apiClient.getData(ApiConfig.signInUri+email);
  }

  Future<bool> saveUserToken(String token) async{
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(ApiConfig.token, token);
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(ApiConfig.token);
  }

  Future<bool> saveVerificationCode(int code) async{
    return await sharedPreferences.setInt(ApiConfig.verificationCode, code);
  }

  Future<bool> savePhoneNumber(String phone) async{
    return await sharedPreferences.setString(ApiConfig.phoneNumber, phone);
  }

  Future<bool> saveEmail(String email) async{
    return await sharedPreferences.setString(ApiConfig.email, email);
  }

  int getVerificationCode() {
    return sharedPreferences.getInt(ApiConfig.verificationCode) ?? 0;
  }

  String getPhoneNumber() {
    return sharedPreferences.getString(ApiConfig.phoneNumber) ?? '';
  }

  String getEmail() {
    return sharedPreferences.getString(ApiConfig.email) ?? '';
  }

  Future<bool> setName(String name) async{
    return await sharedPreferences.setString(ApiConfig.name, name);
  }

  String getName() {
    return sharedPreferences.getString(ApiConfig.name) ?? '';
  }

  Future<bool> clearSharedData() async {
    sharedPreferences.remove(ApiConfig.token);
    sharedPreferences.remove(ApiConfig.name);
    return true;
  }

  Future<void> createChatUser(Map map) async{
    int strId = map["user"]["id"];
    int id = 1000 + strId;
    final uuid = Uuid();
    final randomUuid = uuid.v4();

    final random = Random();
    final timeStamp = DateTime.now().millisecondsSinceEpoch;
    final randomPart = random.nextInt(999999999);

    await apiClient.postData(ApiConfig.signalRBaseUrl, {
      "id": '$timeStamp$randomPart'.padRight(24,'0').toString(),
      "userId": id.toString(),
      "nickName": map["user"]["email"].toString(),
      "photo": "a",
      "isActive": false,
    });
  }
}