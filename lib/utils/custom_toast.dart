
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showCustomToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black.withOpacity(0.8),
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM
  );
}
