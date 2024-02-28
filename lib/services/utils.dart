import 'dart:math';

import 'package:flutix/model/dates.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Utils {
  static String format(int value) {
    final formatCurrency =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
    return formatCurrency.format(value);
  }

  static void showToastMessage(String message) {
    Fluttertoast.showToast(msg: message);
  }

  static List<Dates> generateDatesForWeek(DateTime startDate) {
    List<Dates> dates = [];
    for (int i = 0; i < 7; i++) {
      DateTime currentDate = startDate.add(Duration(days: i));
      String formattedDate = '${currentDate.day}';
      String formattedDay = _getWeekday(currentDate.weekday);
      String formattedDates = DateFormat('yyyy-MM-dd').format(currentDate);
      print(formattedDates);
      dates.add(Dates(
          date: formattedDate, day: formattedDay, fulldate: formattedDates));
    }
    return dates;
  }

  static String _getWeekday(int weekday) {
    switch (weekday) {
      case 1:
        return 'MON';
      case 2:
        return 'TUE';
      case 3:
        return 'WED';
      case 4:
        return 'THU';
      case 5:
        return 'FRI';
      case 6:
        return 'SAT';
      case 7:
        return 'SUN';
      default:
        return '';
    }
  }

  static int generateRandomNumber() {
    Random random = Random();
    // Define the range for the random number (8 digits)
    int min = 10000000; // Minimum 8-digit number
    int max = 99999999; // Maximum 8-digit number
    // Generate and return the random number
    return min + random.nextInt(max - min);
  }
}
