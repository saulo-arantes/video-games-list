import 'package:intl/intl.dart';

class Dates {
  static String format({DateTime date}) {
    int year;
    String month, day;

    year = date.year;

    month = date.month < 10 ? "0${date.month}" : "${date.month}";

    day = date.day < 10 ? "0${date.day}" : "${date.day}";

    return "$year-$month-$day";
  }

  static convert({
    String date,
    String format
  }) {
    if (date.isNotEmpty) {
      List<String> splitedDate = date.split("-");
      DateTime dateTime = new DateTime(
        int.parse(splitedDate[0]),
        int.parse(splitedDate[1]),
        int.parse(splitedDate[2])
      );

      return new DateFormat(format ?? "MMMM dd, yyyy").format(dateTime);
    }

    return "";
  }
}