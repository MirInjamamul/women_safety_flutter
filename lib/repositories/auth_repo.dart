
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/remote/api_client.dart';
import '../utils/api_config.dart';

class AuthRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> loginWithPhone(
      {required String phone}) async {
    return await apiClient.postData(ApiConfig.signInWithPhoneUri, {"phone_number": phone, "type": 0});
  }

  Future<Response> signUpWithPhone(
      {required String phone, required String fname,required String lname}) async {
    return await apiClient.postData(ApiConfig.signUpWithPhoneUri, {"phone_number": phone, "type": 0, "first_name": fname, "last_name": lname});
  }

  Future<Response> loginWithEmail(
      {required String email, required String password}) async {
    return await apiClient.postData(ApiConfig.loginWithEmailUri, {"email": email, "type":0, "password": password});
  }

  Future<Response> signUp(
      {required String email, required String password, required String username, required String mobile}) async {
    return await apiClient.postData(ApiConfig.signUpUri, {
      "name": username,
      "email": email,
      "mobile": mobile,
      "password": password
    });
  }

  Future<Response> checkOTP(
      {required String otp, required String phone}
      )async{
    return await apiClient.postData(ApiConfig.phoneConfirmation, {"phone_number": phone, "verification_number": otp});
  }

  Future<Response> checkOTPEmail(
      {required String otp, required String email}
      )async{
    return await apiClient.postData(ApiConfig.emailConfirmationUri, {"email": email, "verification_number": otp});
  }

  Future<Response> updateUserInfo(
      {required String first, required String last, required String phone}
      )async{
    return await apiClient.postData(ApiConfig.updateInfoByPhoneUri1+phone+ApiConfig.updateInfoByPhoneUri2, {"first_name": first, "last_name": last});
  }

  Future<bool> saveUserToken(String token) async{
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(ApiConfig.token, token);
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
}