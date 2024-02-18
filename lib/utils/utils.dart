import 'package:intl/intl.dart';

String getNumberFotmatString(int value) {
  final NumberFormat numberFormat = NumberFormat("###,###", "en_US");
  return numberFormat.format(value);
}

String getDateFormatString(String value) {
  DateFormat date = DateFormat('yyyy-MM-dd HH:mm');
  return date.format(DateTime.parse(value).toLocal());
}
