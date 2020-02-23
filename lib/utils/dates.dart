import 'package:intl/intl.dart';

class Dates {
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

      return new DateFormat("MMMM dd, yyyy").format(dateTime);
    }

    return "";
  }
}