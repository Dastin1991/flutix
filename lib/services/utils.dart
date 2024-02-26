import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Utils {
  static String format(int value) {
    final formatCurrency =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
    return formatCurrency.format(value);
  }

  void showToastMessage(String message) {
    Fluttertoast.showToast(msg: message);
  }
}
