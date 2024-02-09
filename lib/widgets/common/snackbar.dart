import 'package:find_friend/utils/exceptions/clientException.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';

const Color _backgroundColor = Color.fromARGB(150, 0, 0, 0);

class CustomSnackbar {
  static void showSuccessSnackbar(
      {required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      colorText: Colors.white,
      backgroundColor: _backgroundColor,
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
      backgroundColor: _backgroundColor,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10),
    );
  }

  static void showDefaultErrorSnackbar(
      {required String title, required Object error}) {
    Get.snackbar(
      title,
      error.toString(),
      colorText: Colors.white,
      backgroundColor: _backgroundColor,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10),
    );
  }
}
