
import 'package:women_safety_flutter/api_client.dart';
import 'package:women_safety_flutter/pages/screens.dart';

class HomeRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  HomeRepo({required this.apiClient, required this.sharedPreferences});


}