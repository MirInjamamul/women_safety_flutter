


import 'package:women_safety_flutter/utils/helper.dart';

class BaseController{

  showLoading([String? message]) {
    DialogHelper.showLoading(message ?? 'Processing...');
  }
  hideLoading() {
    DialogHelper.hideLoading();
  }
}