import 'package:intl/intl.dart';

//this basically is to convert date/day/time from calendar to string
class DateConverted {
  static String getDate(DateTime date) {
    return DateFormat.yMd().format(date);
  }

  static String getDay(int day) {
    switch (day) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return 'Sunday';
    }
  }

  static String getTime(int time) {
    switch (time) {
      case 0:
        return '6:00 AM';
      case 1:
        return '7:00 AM';
      case 2:
        return '8:00 AM';
      case 3:
        return '9:00 PM';
      case 4:
        return '10:00 PM';
      case 5:
        return '11:00 PM';
      case 6:
        return '12:00 PM';
      case 7:
        return '13:00 PM';
      case 8:
        return '14:00 PM';
      case 9:
        return '15:00 PM';
      case 10:
        return '16:00 PM';
      case 11:
        return '17:00 PM';
      case 12:
        return '18:00 PM';
      case 13:
        return '19:00 PM';
      case 14:
        return '20:00 PM';

      default:
        return '9:00 AM';
    }
  }
}
