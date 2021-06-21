import 'package:intl/intl.dart';

class StringUtil {
  static String convertDate(DateTime date) {
    final f = DateFormat('dd/MM/yyyy');

    return f.format(date).toString();
  }

  static String convertMoneyString(double d) {
    if (d == 0.0) {
      final currency = NumberFormat("0.00", "pt_BR");
      return currency.format(d);
    }
    final currency = NumberFormat("##0.00", "pt_BR");
    return currency.format(d);
  }
}
