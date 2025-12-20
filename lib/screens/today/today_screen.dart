// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ethio_cal/services/ethiopian_date_service.dart';
import 'package:ethio_cal/services/widget_service.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  late String _ethiopianDate;
  late String _ethiopianDay;
  DateTime _currentTime = DateTime.now();
  Timer? _timer;

  bool is24Hour = true;
  static const String _timeKey = 'is24Hour';

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _updateDateStrings();
    _startSyncedTimer();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      is24Hour = prefs.getBool(_timeKey) ?? true;
    });
  }

  Future<void> _toggleTimeFormat(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => is24Hour = value);
    await prefs.setBool(_timeKey, value);
  }

  void _updateDateStrings() {
    setState(() {
      _ethiopianDate = EthiopianDateService.getFormattedDate();
      _ethiopianDay = EthiopianDateService.getDayOnly();
    });
  }

  // all i know is that it ticks per minute
  void _startSyncedTimer() {
    final now = DateTime.now();
    final int delay = (60 - now.second) * 1000 - now.millisecond;
    Future.delayed(Duration(milliseconds: delay), () {
      if (mounted) {
        _tick();
        _timer = Timer.periodic(const Duration(minutes: 1), (timer) => _tick());
      }
    });
  }

  void _tick() => setState(() => _currentTime = DateTime.now());

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    const Color richBlack = Color(0xFF3D312A);
    final Color highlightColor = isDark ? Colors.white : richBlack;

    var timeStyle = GoogleFonts.chauPhilomeneOne(
      fontSize: 160,
      fontWeight: FontWeight.w700,
      height: 1.0,
      color: highlightColor,
    );

    var dayStyle = GoogleFonts.chauPhilomeneOne(
      fontSize: 72,
      fontWeight: FontWeight.w900,
      color: highlightColor,
      height: 1.1,
    );

    var dateStyle = GoogleFonts.chauPhilomeneOne(
      fontSize: 34,
      color: highlightColor.withOpacity(0.7),
    );

    String hour = is24Hour
        ? DateFormat('HH').format(_currentTime)
        : DateFormat('hh').format(_currentTime);
    String minute = DateFormat('mm').format(_currentTime);
    String amPm = DateFormat('a').format(_currentTime);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: _buildBwSwitcher(isDark, richBlack),
            ),
            const Spacer(),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(hour, style: timeStyle),
                  Transform.translate(
                    offset: const Offset(0, -14),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        ':',
                        style: timeStyle.copyWith(
                          color: highlightColor.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                  Text(minute, style: timeStyle),
                  if (!is24Hour) ...[
                    const SizedBox(width: 12),
                    Text(
                      amPm,
                      style: GoogleFonts.chauPhilomeneOne(
                        fontSize: 30,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(_ethiopianDay, style: dayStyle, textAlign: TextAlign.center),
            Text(_ethiopianDate, style: dateStyle, textAlign: TextAlign.center),
            const SizedBox(height: 30),
            _buildSyncButton(isDark, richBlack),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildSyncButton(bool isDark, Color richBlack) {
    return GestureDetector(
      onTap: () async {
        await WidgetService.updateHomeWidget();
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: richBlack,
            content: Text(
              'Widgets Synced',
              style: GoogleFonts.chauPhilomeneOne(color: Colors.white),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isDark ? Colors.white : richBlack,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.refresh_rounded,
              size: 18,
              color: isDark ? richBlack : Colors.white,
            ),
            const SizedBox(width: 8),
            Text(
              "SYNC WIDGETS",
              style: GoogleFonts.chauPhilomeneOne(
                fontSize: 16,
                letterSpacing: 1.2,
                color: isDark ? richBlack : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBwSwitcher(bool isDark, Color richBlack) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _switchItem(
          "12h",
          !is24Hour,
          isDark,
          richBlack,
          () => _toggleTimeFormat(false),
        ),

        const SizedBox(width: 16),

        _switchItem(
          "24h",
          is24Hour,
          isDark,
          richBlack,
          () => _toggleTimeFormat(true),
        ),
      ],
    );
  }

  Widget _switchItem(
    String label,
    bool active,
    bool isDark,
    Color richBlack,
    VoidCallback onTap,
  ) {
    final Color contentColor = isDark ? Colors.white : richBlack;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque, // makes the entire area clickable
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: active ? contentColor : Colors.transparent,
              width: 2.0,
            ),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.chauPhilomeneOne(
            color: active ? contentColor : contentColor.withOpacity(0.4),
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
