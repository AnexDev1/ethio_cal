import 'package:ethio_cal/screens/home/widgets/tabs.dart';
import 'package:ethio_cal/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  final Widget navigationChild;
  const HomeScreen({super.key, required this.navigationChild});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    bool isToday = location == AppRouter.todayRoute;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.only(top: 26.0)),

            Tabs(
              isSelected: isToday,
              onTabChanged: (bool selectToday) {
                if (selectToday) {
                  context.go(AppRouter.todayRoute);
                } else {
                  context.go(AppRouter.calendarRoute);
                }
              },
            ),

            Expanded(child: widget.navigationChild),
          ],
        ),
      ),
    );
  }
}
