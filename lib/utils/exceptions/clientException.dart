import 'dart:developer';

import 'package:pocketbase/pocketbase.dart';

class ClientExceptionController {
  static String getErrorMessage(Object error) {
    ClientException e = error as ClientException;

    log('ClientExceptionController > $e');

    if (e.response['data']['nickname'] != null) return 'ニックネームが重複しています';
    if (e.response['data']['email'] != null) return 'メールアドレスが重複しています';

    return '問題が発生しました';
  }
}
