
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:women_safety_flutter/helper/remote/api_client.dart';
import 'package:women_safety_flutter/utils/api_config.dart';

class ComplainRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  ComplainRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> createComplain(
    {required String thana, required String complain_type, required String comment}
      )async{

    return await apiClient.postData(ApiConfig.createComplainUri, {
      "thana": thana,
      "complain_type": complain_type,
      "comment": comment
    });
  }



  // Future<Response> deleteComplain(int id) async {
  //   return await apiClient.getData(ApiConfig.getComplainsUri+id.toString());
  // }

}