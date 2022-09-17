
import 'package:intl/intl.dart';

class DateFormatter {

  static String convertTimeStampToString(DateTime dt) {
    return DateFormat('MM/dd/yyyy hh:mm a').format(dt);
  }

}