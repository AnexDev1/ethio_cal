import 'package:ethiopian_datetime/ethiopian_datetime.dart';

class EthiopianDateService {
  static const Map<String, String> dayMaps = {
    'ሶኒ': 'ሰኞ',
    'ሰሉስ': 'ማክሰኞ',
    'ረቡዕ': 'ረቡዕ',
    'ሓሙስ': 'ሐሙስ',
    'ዓርቢ': 'ዓርብ',
    'ቀዳም': 'ቅዳሜ',
    'ሰንበት': 'እሑድ',
  };

  static String getFormattedDate() {
    ETDateTime now = ETDateTime.now();

    final dateTime = ETDateFormat("dd-MMMM-yyyy HH:mm:ss").format(now);
    final tempDate = dateTime.split(" ")[0].split("-");

    // print("Temp Date: $tempDate");
    final actualDate = "${tempDate[1]} ${tempDate[0]} ${tempDate[2]}";

    return actualDate;
  }

  static String getDayOnly() {
    ETDateTime now = ETDateTime.now();
    final formattedDate = ETDateFormat.MMMMEEEEd('ti').format(now);
    final unmapped = formattedDate.split(",")[0];
    return dayMaps[unmapped] ?? unmapped;
  }
}
