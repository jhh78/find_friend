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

  static void showErrorSnackbar(
      {required String title, required dynamic error}) {
    if (error is ClientException) {
      String errorMessage = '問題が発生しました';

      if (error.response['data']['nickname'] != null) {
        errorMessage = 'ニックネームが重複しています';
      } else if (error.response['data']['email'] != null) {
        errorMessage = 'メールアドレスが重複しています';
      }

      Get.snackbar(
        title,
        errorMessage,
        colorText: Colors.white,
        backgroundColor: Colors.red[500],
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
      );
    } else {
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
}
