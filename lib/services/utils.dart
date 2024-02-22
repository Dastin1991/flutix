import 'package:intl/intl.dart';

class RupiahFormatter {
  static String format(int value) {
    final formatCurrency =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
    return formatCurrency.format(value);
  }
}
