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
    print("date from package: $now");

    // final dateTime = ETDateFormat("dd-MMMM-yyyy HH:mm:ss").format(now);
    final dateTime = ETDateFormat("MMMM-dd-yyyy").format(now);

    print("DATETIME $dateTime");
    final tempDate = dateTime.split(" ")[0].split("-");

    print("TEMP DATE: $tempDate");
    final actualDate = "${tempDate[0]} ${tempDate[1]} ${tempDate[2]}";

    print("ACTUAL DATE $actualDate");
    return actualDate;
  }

  static String getDayOnly() {
    ETDateTime now = ETDateTime.now();
    final formattedDate = ETDateFormat.MMMMEEEEd('ti').format(now);
    print("FORMATTED DATE: $formattedDate");
    final unmapped = formattedDate.split(",")[0];
    print("UNMAPPED $unmapped");
    return dayMaps[unmapped] ?? unmapped;
  }
}
