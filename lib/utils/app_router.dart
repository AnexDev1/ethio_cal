import 'package:go_router/go_router.dart';
import 'package:ethio_cal/screens/home/home_screen.dart';
import 'package:ethio_cal/screens/today/today_screen.dart';
import 'package:ethio_cal/screens/calendar/calendar_screen.dart';

class AppRouter {
  static const String todayRoute = '/today';
  static const String calendarRoute = '/calendar';

  static final GoRouter router = GoRouter(
    // initialLocation: todayRoute,
    initialLocation: calendarRoute,
    routes: [
      ShellRoute(
        builder: (context, state, child) => HomeScreen(navigationChild: child),
        routes: [
          GoRoute(
            path: todayRoute,
            builder: (context, state) => const TodayScreen(),
          ),
          GoRoute(
            path: calendarRoute,
            builder: (context, state) => const CalendarScreen(),
          ),
        ],
      ),
    ],
  );
}
