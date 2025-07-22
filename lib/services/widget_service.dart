import 'package:home_widget/home_widget.dart';
import 'ethiopian_date_service.dart';

class WidgetService {
  /// Updates the home widget with the current Ethiopian date and day name in Amharic.
  static Future<void> updateHomeWidget() async {
    final now = DateTime.now();
    final ethio = EthiopianDateService.getEthiopianDateInfo(now);
    await HomeWidget.saveWidgetData<String>('ethiopian_date', ethio['date']!);
    await HomeWidget.saveWidgetData<String>('ethiopian_day', ethio['day']!);
    await HomeWidget.saveWidgetData<String>(
      'ethiopian_date',
      '2025 ሐምሌ 1',
    ); // Use standard numbers
    await HomeWidget.saveWidgetData<String>('ethiopian_day', 'ሰኞ');
    await HomeWidget.updateWidget(
      qualifiedAndroidName: 'com.anexon.ethio_cal.HomeWidgetProvider',
    );
  }
}
