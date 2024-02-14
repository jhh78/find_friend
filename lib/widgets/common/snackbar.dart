import 'package:find_friend/utils/exceptions/clientException.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';

class CustomSnackbar {
  static void showSuccessSnackbar(
      {required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      colorText: Colors.white,
      backgroundColor: Colors.blueAccent,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10),
    );
  }

  static void showClientErrorSnackbar(
      {required String title, required ClientException error}) {
    Get.snackbar(
      title,
      ClientExceptionController.getErrorMessage(error),
      colorText: Colors.white,
      backgroundColor: Colors.red[500],
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10),
    );
  }

  static void showDefaultErrorSnackbar(
      {required String title, required error}) {
    Get.snackbar(
      title,
      error.message.toString(),
      colorText: Colors.white,
      backgroundColor: Colors.red[500],
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10),
    );
  }
}
