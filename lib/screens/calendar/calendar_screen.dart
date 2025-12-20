// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ethio_cal/services/ethiopian_date_service.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final List<String> _months = [
    'መስከረም',
    'ጥቅምት',
    'ኅዳር',
    'ታህሳስ',
    'ጥር',
    'የካቲት',
    'መጋቢት',
    'ሚያዝያ',
    'ግንቦት',
    'ሰኔ',
    'ሐምሌ',
    'ነሀሴ',
    'ጳጉሜ',
  ];

  final List<String> _weekDays = [
    'እሁድ',
    'ሰኞ',
    'ማክሰኞ',
    'ረቡዕ',
    'ሐሙስ',
    'ዓርብ',
    'ቅዳሜ',
  ];

  late int _viewMonth, _viewYear;
  late int _todayDay, _todayMonth, _todayYear;

  @override
  void initState() {
    super.initState();
    _todayDay = EthiopianDateService.getCurrentDay();
    _todayMonth = EthiopianDateService.getCurrentMonth();
    _todayYear = EthiopianDateService.getCurrentYear();
    _viewMonth = _todayMonth;
    _viewYear = _todayYear;
  }

  void _jumpToToday() {
    setState(() {
      _viewMonth = _todayMonth;
      _viewYear = _todayYear;
    });
  }

  void _changeMonth(int off) {
    setState(() {
      _viewMonth += off;
      if (_viewMonth > 13) {
        _viewMonth = 1;
        _viewYear++;
      } else if (_viewMonth < 1) {
        _viewMonth = 13;
        _viewYear--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    const Color richBlack = Color(0xFF3D312A);
    final Color highlightColor = isDark ? Colors.white : richBlack;

    int offset = EthiopianDateService.getFirstWeekdayOfMonth(
      _viewYear,
      _viewMonth,
    );
    int daysCount = EthiopianDateService.getDaysInMonth(_viewYear, _viewMonth);
    bool isShowingToday =
        (_viewMonth == _todayMonth && _viewYear == _todayYear);

    Map<int, String> monthHolidays = EthiopianDateService.getEventsForMonth(
      _viewYear,
      _viewMonth,
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Column(
          children: [
            _buildHeader(highlightColor, isShowingToday),
            const SizedBox(height: 10),
            _buildWeekdayLabels(highlightColor),
            const Divider(height: 20, color: Colors.grey),

            Flexible(
              flex: 4,
              child: GridView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1.15, // flattens cells to push them up
                ),
                itemCount: daysCount + offset,
                itemBuilder: (context, index) {
                  if (index < offset) return const SizedBox.shrink();
                  int dayNum = index - offset + 1;
                  bool isToday = (dayNum == _todayDay && isShowingToday);
                  bool hasHoliday = monthHolidays.containsKey(dayNum);

                  return _buildDayCell(
                    dayNum,
                    isToday,
                    hasHoliday,
                    isDark,
                    richBlack,
                    highlightColor,
                  );
                },
              ),
            ),

            // Events list
            Expanded(
              flex: 4,
              child: _buildEventsSection(monthHolidays, highlightColor),
            ),

            Text(
              'Ethiopian Calendar $_viewYear E.C',
              style: GoogleFonts.chauPhilomeneOne(
                fontSize: 12,
                color: highlightColor.withOpacity(0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventsSection(Map<int, String> holidays, Color highlight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "EVENTS",
          style: GoogleFonts.chauPhilomeneOne(fontSize: 22, color: highlight),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: holidays.isEmpty
              ? Center(
                  child: Text(
                    "No events this month",
                    style: GoogleFonts.chauPhilomeneOne(
                      color: highlight.withOpacity(0.3),
                    ),
                  ),
                )
              : ListView(
                  padding: EdgeInsets.zero,
                  children: holidays.entries.map((entry) {
                    return _buildEventItem(
                      entry.value,
                      "Day ${entry.key}",
                      highlight,
                    );
                  }).toList(),
                ),
        ),
      ],
    );
  }

  Widget _buildEventItem(String title, String date, Color highlight) {
    Color barColor = highlight;
    if (title.contains('ዒድ') || title.contains('መውሊድ')) {
      barColor = Colors.orangeAccent;
    } else if (title.contains('ፋሲካ') ||
        title.contains('መስቀል') ||
        title.contains('ጥምቀት') ||
        title.contains('ገና') ||
        title.contains('ጾም') ||
        title.contains('ስቅለት')) {
      barColor = Colors.lightBlueAccent;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: barColor.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: barColor.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 30,
            decoration: BoxDecoration(
              color: barColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.chauPhilomeneOne(
                  fontSize: 16,
                  color: highlight,
                ),
              ),
              Text(
                date,
                style: GoogleFonts.chauPhilomeneOne(
                  fontSize: 12,
                  color: highlight.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDayCell(
    int day,
    bool isToday,
    bool hasEvent,
    bool isDark,
    Color brown,
    Color highlight,
  ) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: isToday ? highlight : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isToday ? Colors.transparent : highlight.withOpacity(0.1),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            day.toString(),
            style: GoogleFonts.chauPhilomeneOne(
              fontSize: 18,
              color: isToday ? (isDark ? brown : Colors.white) : highlight,
            ),
          ),
          // LINE INDICATOR
          if (hasEvent && !isToday)
            Positioned(
              bottom: 4,
              child: Container(
                width: 20,
                height: 1,
                decoration: BoxDecoration(
                  color: highlight.withOpacity(0.6),
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader(Color color, bool isShowingToday) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _viewYear.toString(),
              style: GoogleFonts.chauPhilomeneOne(
                fontSize: 16,
                color: color.withOpacity(0.5),
              ),
            ),
            Text(
              _months[_viewMonth - 1],
              style: GoogleFonts.chauPhilomeneOne(
                fontSize: 34,
                color: color,
                height: 1.0,
              ),
            ),
          ],
        ),
        Row(
          children: [
            if (!isShowingToday) _navBtn(Icons.today, _jumpToToday, color),
            const SizedBox(width: 8),
            _navBtn(Icons.chevron_left, () => _changeMonth(-1), color),
            const SizedBox(width: 8),
            _navBtn(Icons.chevron_right, () => _changeMonth(1), color),
          ],
        ),
      ],
    );
  }

  Widget _buildWeekdayLabels(Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: _weekDays
          .map(
            (d) => Text(
              d,
              style: GoogleFonts.chauPhilomeneOne(
                color: color.withOpacity(0.4),
                fontSize: 14,
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _navBtn(IconData icon, VoidCallback? onTap, Color color) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(0.05),
        ),
        child: Icon(icon, color: color, size: 24),
      ),
    );
  }
}
