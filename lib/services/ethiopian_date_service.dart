import 'package:ethiopian_datetime/ethiopian_datetime.dart';

class EthiopianDateService {
  static const Map<int, String> monthMaps = {
    1: 'መስከረም',
    2: 'ጥቅምት',
    3: 'ኅዳር',
    4: 'ታህሳስ',
    5: 'ጥር',
    6: 'የካቲት',
    7: 'መጋቢት',
    8: 'ሚያዝያ',
    9: 'ግንቦት',
    10: 'ሰኔ',
    11: 'ሐምሌ',
    12: 'ነሀሴ',
    13: 'ጳጉሜ',
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

  static int getDaysInMonth(int year, int month) {
    if (month < 13) return 30;
    return (year + 1) % 4 == 0 ? 6 : 5;
  }

  static String getFormattedDate() {
    ETDateTime now = ETDateTime.now();
    final formattedDate = ETDateFormat.MMMMEEEEd('ti').format(now);
    print("FORMATTED DATE: $formattedDate");
    final unmapped = formattedDate.split(",")[0];
    print("UNMAPPED $unmapped");
    return dayMaps[unmapped] ?? unmapped;
  }
}
