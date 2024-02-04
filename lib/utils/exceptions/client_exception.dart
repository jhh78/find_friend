import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

class ClientExceptionController {
  static String getErrorMessage(Object error) {
    ClientException e = error as ClientException;
    debugPrint('登録失敗 ${e.response['data']['nickname']}');

    if (e.response['data']['nickname'] != null) return 'ニックネームが重複しています';
    if (e.response['data']['email'] != null) return 'メールアドレスが重複しています';

    return '登録に失敗しました';
  }
}
