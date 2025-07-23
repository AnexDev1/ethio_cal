import 'package:ethiopian_calendar/ethiopian_date_converter.dart';
import 'package:ethiopian_calendar/ethiopian_date_formatter.dart';

class EthiopianDateService {
  /// Returns a formatted Ethiopian date and day name in Amharic for the given [dateTime].
  static Map<String, String> getEthiopianDateInfo(DateTime dateTime) {
    final ethioDate = EthiopianDateConverter.convertToEthiopianDate(dateTime);
    // Format as 'MMMM dd yyyy' (month day year, space separated)
    final formattedDate = EthiopianDateFormatter(
      'MMMM dd yyyy',
      'am',
    ).format(ethioDate);
    final dayNames = ['እሑድ', 'ሰኞ', 'ማክሰኞ', 'ረቡዕ', 'ሐሙስ', 'ዓርብ', 'ቅዳሜ'];
    final dayName = dayNames[dateTime.weekday % 7];
    return {'date': formattedDate, 'day': dayName};
  }
}
