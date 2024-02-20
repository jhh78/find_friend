import 'package:find_friend/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:pocketbase/pocketbase.dart';

String getNumberFotmatString(int value) {
  final NumberFormat numberFormat = NumberFormat("###,###", "en_US");
  return numberFormat.format(value);
}

String getDateFormatString(String value) {
  DateFormat date = DateFormat('yyyy-MM-dd HH:mm');
  return date.format(DateTime.parse(value).toLocal());
}

void writeLogs({required String name, required dynamic error}) {
  final pb = PocketBase(API_URL);
  final body = <String, dynamic>{"message": error.toString(), "name": name};

  pb.collection('errors').create(body: body);
}
