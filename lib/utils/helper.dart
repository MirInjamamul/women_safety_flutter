import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogHelper {
  //show error dialog
  static void showErrorDialog({String title = 'Error', String? description = 'Something went wrong'}) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Get.textTheme.headline4,
              ),
              Text(
                description ?? '',
                style: Get.textTheme.headline6,
              ),
              ElevatedButton(
                onPressed: () {
                  if (Get.isDialogOpen!) Get.back();
                },
                child: const Text('Okay'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //show toast
  //show snack bar
  //show loading
  static void showLoading([String? message]) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30, width: 30,child: Center(child: CircularProgressIndicator(strokeWidth: 3,))),
              const SizedBox(width: 15),
              Text(message ?? 'Loading...'),
            ],
          ),
        ),
      ),
    );
  }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }
}