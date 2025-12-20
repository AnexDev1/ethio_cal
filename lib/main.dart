import 'package:ethio_cal/services/background_callback.dart';
import 'package:ethio_cal/services/update_widget_background.dart';
import 'package:ethio_cal/services/widget_service.dart';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:provider/provider.dart';
import 'package:ethio_cal/providers/theme_provider.dart';
import 'package:ethio_cal/utils/app_router.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Schedule the widget update every hour
  await AndroidAlarmManager.initialize();
  await WidgetService.updateHomeWidget();
  HomeWidget.registerInteractivityCallback(backgroundCallback);

  await AndroidAlarmManager.periodic(
    const Duration(hours: 1),
    0,
    updateWidgetBackground,
    startAt: DateTime.now().add(const Duration(seconds: 5)),
    exact: true,
    wakeup: true,
    rescheduleOnReboot: true,
  );

  final themeProvider = ThemeProvider();
  await themeProvider.init();

  runApp(
    ChangeNotifierProvider.value(value: themeProvider, child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.lightTheme,
      darkTheme: themeProvider.darkTheme,
      themeMode: themeProvider.themeMode,
      routerConfig: AppRouter.router,
    );
  }
}
