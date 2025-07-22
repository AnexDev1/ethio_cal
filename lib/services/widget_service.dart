import 'package:home_widget/home_widget.dart';
import 'ethiopian_date_service.dart';

class WidgetService {
  static Future<void> updateHomeWidget() async {
    final now = DateTime.now();
    final ethio = EthiopianDateService.getEthiopianDateInfo(now);
    await HomeWidget.saveWidgetData<String>('ethiopian_date', ethio['date']!);
    await HomeWidget.saveWidgetData<String>('ethiopian_day', ethio['day']!);

    await HomeWidget.updateWidget(
      qualifiedAndroidName: 'com.anexon.ethio_cal.MyHomeWidgetProvider',
    );
  }
}
