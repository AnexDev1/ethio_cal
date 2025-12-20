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

  static const List<String> amharicDays = [
    'ሰኞ',
    'ማክሰኞ',
    'ረቡዕ',
    'ሐሙስ',
    'ዓርብ',
    'ቅዳሜ',
    'እሁድ',
  ];

  // fixed (same every year)
  static const Map<String, String> _fixedEvents = {
    '1-1': 'እንቁጣጣሽ (New Year)',
    '1-17': 'መስቀል (Finding of True Cross)',
    '4-29': 'ገና (Christmas)',
    '5-11': 'ጥምቀት (Epiphany)',
    '6-23': 'የዓድዋ ድል (Adwa Victory)',
    '8-23': 'ሜይ ዴይ (Labour Day)',
    '8-27': 'የአርበኞች ቀን (Patriots\' Day)',
    '9-20': 'ግንቦት 20 (Derg Downfall)',
  };

  static const Map<String, String> _dynamicEvents = {
    // lame approach but "who cares, who cares bratha, today, today SMESH"

    // --- 2017  ---
    '2017-1-6': 'መውሊድ (Mawlid)',
    '2017-7-22': 'ዒድ አል-ፊጥር (Eid al-Fitr)',
    '2017-8-10': 'ስቅለት (Good Friday)',
    '2017-8-12': 'ፋሲካ (Easter)',
    '2017-9-30': 'ዒድ አል-አድሐ (Eid al-Adha)',
    '2017-12-30': 'መውሊድ (Mawlid)',
    // --- 2018  ---
    '2018-7-11': 'ዒድ አል-ፊጥር (Eid al-Fitr)',
    '2018-8-2': 'ስቅለት (Good Friday)',
    '2018-8-4': 'ፋሲካ (Easter)',
    '2018-9-19': 'ዒድ አል-አድሐ (Eid al-Adha)',
    '2018-12-20': 'መውሊድ (Mawlid)',
    // --- 2019  ---
    '2019-7-1': 'ዒድ አል-ፊጥር (Eid al-Fitr)',
    '2019-8-22': 'ስቅለት (Good Friday)',
    '2019-8-24': 'ፋሲካ (Easter)',
    '2019-9-9': 'ዒድ አል-አድሐ (Eid al-Adha)',
    '2019-12-9': 'መውሊድ (Mawlid)',
    // --- 2020  ---
    '2020-6-19': 'ዒድ አል-ፊጥር (Eid al-Fitr)',
    '2020-8-6': 'ስቅለት (Good Friday)',
    '2020-8-8': 'ፋሲካ (Easter)',
    '2020-8-27': 'ዒድ አል-አድሐ (Eid al-Adha)',
    '2020-11-27': 'መውሊድ (Mawlid)',
    // --- 2021  ---
    '2021-6-8': 'ዒድ አል-ፊጥር (Eid al-Fitr)',
    '2021-7-28': 'ስቅለት (Good Friday)',
    '2021-7-30': 'ፋሲካ (Easter)',
    '2021-8-16': 'ዒድ አል-አድሐ (Eid al-Adha)',
    '2021-11-17': 'መውሊድ (Mawlid)',
    // --- 2022  ---
    '2022-5-28': 'ዒድ አል-ፊጥር (Eid al-Fitr)',
    '2022-8-6': 'ዒድ አል-አድሐ (Eid al-Adha)',
    '2022-8-18': 'ስቅለት (Good Friday)',
    '2022-8-20': 'ፋሲካ (Easter)',
    '2022-11-6': 'መውሊድ (Mawlid)',
    // --- 2023  ---
    '2023-5-17': 'ዒድ አል-ፊጥር (Eid al-Fitr)',
    '2023-7-25': 'ዒድ አል-አድሐ (Eid al-Adha)',
    '2023-8-3': 'ስቅለት (Good Friday)',
    '2023-8-5': 'ፋሲካ (Easter)',
    '2023-10-25': 'መውሊድ (Mawlid)',
    // --- 2024  ---
    '2024-5-5': 'ዒድ አል-ፊጥር (Eid al-Fitr)',
    '2024-7-13': 'ዒድ አል-አድሐ (Eid al-Adha)',
    '2024-8-22': 'ስቅለት (Good Friday)',
    '2024-8-24': 'ፋሲካ (Easter)',
    '2024-10-14': 'መውሊድ (Mawlid)',
    // --- 2025  ---
    '2025-4-25': 'ዒድ አል-ፊጥር (Eid al-Fitr)',
    '2025-7-3': 'ዒድ አል-አድሐ (Eid al-Adha)',
    '2025-8-14': 'ስቅለት (Good Friday)',
    '2025-8-16': 'ፋሲካ (Easter)',
    '2025-10-3': 'መውሊድ (Mawlid)',
    // --- 2026  ---
    '2026-4-14': 'ዒድ አል-ፊጥር (Eid al-Fitr)',
    '2026-6-22': 'ዒድ አል-አድሐ (Eid al-Adha)',
    '2026-7-29': 'ስቅለት (Good Friday)',
    '2026-8-1': 'ፋሲካ (Easter)',
    '2026-9-22': 'መውሊድ (Mawlid)',
    // --- 2027  ---
    '2027-4-3': 'ዒድ አል-ፊጥር (Eid al-Fitr)',
    '2027-6-11': 'ዒድ አል-አድሐ (Eid al-Adha)',
    '2027-8-19': 'ስቅለት (Good Friday)',
    '2027-8-21': 'ፋሲካ (Easter)',
    '2027-9-12': 'መውሊድ (Mawlid)',
    // --- 2028  ---
    '2028-3-22': 'ዒድ አል-ፊጥር (Eid al-Fitr)',
    '2028-5-30': 'ዒድ አል-አድሐ (Eid al-Adha)',
    '2028-8-10': 'ስቅለት (Good Friday)',
    '2028-8-12': 'ፋሲካ (Easter)',
    '2028-8-30': 'መውሊድ (Mawlid)',
    // --- 2029  ---
    '2029-3-11': 'ዒድ አል-ፊጥር (Eid al-Fitr)',
    '2029-5-19': 'ዒድ አል-አድሐ (Eid al-Adha)',
    '2029-7-25': 'ስቅለት (Good Friday)',
    '2029-7-27': 'ፋሲካ (Easter)',
    '2029-8-20': 'መውሊድ (Mawlid)',
    // --- 2030  ---
    '2030-3-1': 'ዒድ አል-ፊጥር (Eid al-Fitr)',
    '2030-5-9': 'ዒድ አል-አድሐ (Eid al-Adha)',
    '2030-8-9': 'መውሊድ (Mawlid)',
    '2030-8-15': 'ስቅለት (Good Friday)',
    '2030-8-17': 'ፋሲካ (Easter)',
  };

  static Map<int, String> getEventsForMonth(int year, int month) {
    Map<int, String> monthlyEvents = {};

    _fixedEvents.forEach((key, value) {
      var parts = key.split('-');
      if (int.parse(parts[0]) == month) {
        monthlyEvents[int.parse(parts[1])] = value;
      }
    });

    _dynamicEvents.forEach((key, value) {
      var parts = key.split('-');
      if (int.parse(parts[0]) == year && int.parse(parts[1]) == month) {
        monthlyEvents[int.parse(parts[2])] = value;
      }
    });

    return monthlyEvents;
  }

  static String getDayOnly() => amharicDays[ETDateTime.now().weekday - 1];
  static int getCurrentDay() => ETDateTime.now().day;
  static int getCurrentMonth() => ETDateTime.now().month;
  static int getCurrentYear() => ETDateTime.now().year;

  static int getFirstWeekdayOfMonth(int year, int month) {
    return ETDateTime(year, month, 1).weekday % 7;
  }

  static int getDaysInMonth(int year, int month) {
    if (month < 13) return 30;
    return (year + 1) % 4 == 0 ? 6 : 5;
  }

  static String getFormattedDate() {
    ETDateTime now = ETDateTime.now();
    return "${monthMaps[now.month]} ${now.day}, ${now.year}";
  }
}
