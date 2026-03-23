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

  static const Map<int, String> _weekDayNames = {
    1: 'ሰኞ',
    2: 'ማክሰኞ',
    3: 'ረቡዕ',
    4: 'ሐሙስ',
    5: 'ዓርብ',
    6: 'ቅዳሜ',
    7: 'እሁድ',
  };

  static String getFormattedDate() {
    final ETDateTime now = ETDateTime.now();
    final month = monthMaps[now.month] ?? '';
    return '$month ${now.day} ${now.year}';
  }

  static String getDayOnly() {
    final ETDateTime now = ETDateTime.now();
    return _weekDayNames[now.weekday] ?? '';
  }

  static int getCurrentDay() => ETDateTime.now().day;
  static int getCurrentMonth() => ETDateTime.now().month;
  static int getCurrentYear() => ETDateTime.now().year;

  static int getDaysInMonth(int year, int month) {
    if (month < 13) return 30;
    return (year + 1) % 4 == 0 ? 6 : 5;
  }

  static int getFirstWeekdayOfMonth(int year, int month) {
    final first = ETDateTime(year, month, 1);
    // Dart weekday: 1=Monday, 7=Sunday → map to 0=Sunday, 1=Monday, ..., 6=Saturday
    return first.weekday % 7;
  }

  static Map<int, String> getEventsForMonth(int year, int month) {
    final holidays = <int, String>{};
    switch (month) {
      case 1: // Meskerem
        holidays[1] = 'እንቁጣጣሽ';
        holidays[17] = 'መስቀል';
        break;
      case 3: // Hidar
        holidays[6] = 'ልደተ ማርያም';
        break;
      case 4: // Tahsas
        holidays[29] = 'ገና';
        break;
      case 5: // Tir
        holidays[11] = 'ጥምቀት';
        break;
      case 6: // Yekatit
        holidays[23] = 'የዓድዋ ድል';
        break;
      case 8: // Miazia
        holidays[23] = 'የሠራተኞች ቀን';
        holidays[27] = 'የአርበኞች ድል ቀን';
        break;
      case 9: // Ginbot
        holidays[20] = 'የድርጅቱ ቀን';
        break;
    }
    return holidays;
  }

  static String _normalizedDayName(String value) => value.toUpperCase();

  static int _clampPercent(num percent) {
    final p = percent.floor();
    return p < 0 ? 0 : (p > 100 ? 100 : p);
  }

  static Map<String, String> getEthiopianProgressData() {
    final now = ETDateTime.now();
    final hour = DateTime.now().hour;
    final minute = DateTime.now().minute;
    final second = DateTime.now().second;

    final dayFraction = (hour * 3600 + minute * 60 + second) / 86400;
    final dayPercent = _clampPercent(dayFraction * 100);

    final dayOfYear = ((now.month - 1) * 30) + now.day;
    final yearDays = (now.month == 13 ? (getDaysInMonth(now.year, 13)) : 365);
    final totalWeeks = (yearDays / 7.0).ceil();
    final weekNum = ((dayOfYear - 1) ~/ 7) + 1;

    final daysInCurrentWeek = ((dayOfYear - 1) % 7);
    final weekFraction =
        (daysInCurrentWeek * 86400 + hour * 3600 + minute * 60 + second) /
        (7 * 86400);
    final weekFlow = ((weekNum - 1) + weekFraction) / totalWeeks;
    final weekPercent = _clampPercent(weekFlow * 100);

    final daysInMonth = getDaysInMonth(now.year, now.month);
    final monthFlow =
        ((now.day - 1) * 86400 + hour * 3600 + minute * 60 + second) /
        (daysInMonth * 86400);
    final monthPercent = _clampPercent(monthFlow * 100);

    final yearFlow =
        ((dayOfYear - 1) * 86400 + hour * 3600 + minute * 60 + second) /
        (yearDays * 86400);
    final yearPercent = _clampPercent(yearFlow * 100);

    final monthName = monthMaps[now.month] ?? '';
    final weekName = _weekDayNames[now.weekday] ?? '';

    return {
      'ethio_day_label': _normalizedDayName(weekName),
      'ethio_day_percent': '$dayPercent%',
      'ethio_week_label': 'ሳምንት $weekNum',
      'ethio_week_percent': '$weekPercent%',
      'ethio_month_label': monthName.toUpperCase(),
      'ethio_month_percent': '$monthPercent%',
      'ethio_year_label': now.year.toString(),
      'ethio_year_percent': '$yearPercent%',
      'ethio_day_progress': dayPercent.toString(),
      'ethio_week_progress': weekPercent.toString(),
      'ethio_month_progress': monthPercent.toString(),
      'ethio_year_progress': yearPercent.toString(),
    };
  }

  static Map<String, String> getGregorianProgressData() {
    final now = DateTime.now();
    final hour = now.hour;
    final minute = now.minute;
    final second = now.second;

    final dayFraction = (hour * 3600 + minute * 60 + second) / 86400;
    final dayPercent = _clampPercent(dayFraction * 100);

    final dayOfYear = now.difference(DateTime(now.year, 1, 1)).inDays + 1;
    final yearDays = DateTime(
      now.year + 1,
      1,
      1,
    ).difference(DateTime(now.year, 1, 1)).inDays;
    final totalWeeks = (yearDays / 7.0).ceil();
    final weekNum = ((dayOfYear - 1) ~/ 7) + 1;

    final daysInCurrentWeek = ((dayOfYear - 1) % 7);
    final weekFraction =
        (daysInCurrentWeek * 86400 + hour * 3600 + minute * 60 + second) /
        (7 * 86400);

    final weekFlow = ((weekNum - 1) + weekFraction) / totalWeeks;
    final weekPercent = _clampPercent(weekFlow * 100);

    final daysInMonth = DateTime(
      now.year,
      now.month + 1,
      1,
    ).difference(DateTime(now.year, now.month, 1)).inDays;
    final monthFlow =
        ((now.day - 1) * 86400 + hour * 3600 + minute * 60 + second) /
        (daysInMonth * 86400);
    final monthPercent = _clampPercent(monthFlow * 100);

    final yearFlow =
        ((dayOfYear - 1) * 86400 + hour * 3600 + minute * 60 + second) /
        (yearDays * 86400);
    final yearPercent = _clampPercent(yearFlow * 100);

    const weekdayNames = {
      1: 'MONDAY',
      2: 'TUESDAY',
      3: 'WEDNESDAY',
      4: 'THURSDAY',
      5: 'FRIDAY',
      6: 'SATURDAY',
      7: 'SUNDAY',
    };
    const monthNames = {
      1: 'JANUARY',
      2: 'FEBRUARY',
      3: 'MARCH',
      4: 'APRIL',
      5: 'MAY',
      6: 'JUNE',
      7: 'JULY',
      8: 'AUGUST',
      9: 'SEPTEMBER',
      10: 'OCTOBER',
      11: 'NOVEMBER',
      12: 'DECEMBER',
    };
    final weekName = weekdayNames[now.weekday] ?? '';

    return {
      'greg_day_label': weekName,
      'greg_day_percent': '$dayPercent%',
      'greg_week_label': 'WEEK $weekNum',
      'greg_week_percent': '$weekPercent%',
      'greg_month_label': monthNames[now.month] ?? '',
      'greg_month_percent': '$monthPercent%',
      'greg_year_label': now.year.toString(),
      'greg_year_percent': '$yearPercent%',
      'greg_day_progress': dayPercent.toString(),
      'greg_week_progress': weekPercent.toString(),
      'greg_month_progress': monthPercent.toString(),
      'greg_year_progress': yearPercent.toString(),
    };
  }
}
