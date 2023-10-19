import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:women_safety_flutter/utils/api_config.dart';

class LocalizationController  extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;

  LocalizationController({required this.sharedPreferences}) {
    _loadCurrentLanguage();
  }

  Locale _locale = const Locale('de', 'DE');
  bool _isLtr = true;
  Locale get locale => _locale;
  bool get isLtr => _isLtr;

  void setLanguage(Locale locale) {
    _locale = locale;
    if(_locale.languageCode == 'de') {
      _isLtr = false;
    }else {
      _isLtr = true;
    }
    _saveLanguage(_locale);
    Get.updateLocale(locale);
    update();
  }

  int _languageIndex = 0;
  int get languageIndex => _languageIndex;

  void toggleLanguage() {
    if(_locale.languageCode == 'en') {
      _languageIndex = 0;
      _locale = const Locale('bn', 'BD');
      _isLtr = false;
    }else {
      _languageIndex = 1;
      _locale = const Locale('en', 'US');
      _isLtr = true;
    }
    _saveLanguage(_locale);
    Get.updateLocale(locale);
    update();
  }

  _loadCurrentLanguage() async {
    _locale = Locale(sharedPreferences.getString(ApiConfig.languageCode) ?? 'de',
        sharedPreferences.getString(ApiConfig.countryCode) ?? 'DE');
    _isLtr = _locale.languageCode == 'de';
    update();
  }

  _saveLanguage(Locale locale) async {
    sharedPreferences.setString(ApiConfig.languageCode, locale.languageCode);
    sharedPreferences.setString(ApiConfig.countryCode, locale.countryCode!);
  }
}