import 'package:home_widget/home_widget.dart';
import 'ethiopian_date_service.dart';

class WidgetService {
  static Future<void> updateHomeWidget() async {
    final now = DateTime.now();
    final ethio = EthiopianDateService.getEthiopianDateInfo(now);
    await HomeWidget.saveWidgetData<String>('ethiopian_date', ethio['date']!);
    await HomeWidget.saveWidgetData<String>('ethiopian_day', ethio['day']!);

    // Update all widget providers
    await HomeWidget.updateWidget(
      qualifiedAndroidName: 'com.anexon.ethio_cal.MyHomeWidgetProvider',
    );
    await HomeWidget.updateWidget(
      qualifiedAndroidName: 'com.anexon.ethio_cal.MyHomeWidgetDayProvider',
    );
    await HomeWidget.updateWidget(
      qualifiedAndroidName: 'com.anexon.ethio_cal.MyHomeWidgetDayDarkProvider',
    );
    await HomeWidget.updateWidget(
      qualifiedAndroidName: 'com.anexon.ethio_cal.MyHomeWidgetDarkProvider',
    );
    await HomeWidget.updateWidget(
      qualifiedAndroidName: 'com.anexon.ethio_cal.MyHomeWidgetGlassyProvider',
    );
    await HomeWidget.updateWidget(
      qualifiedAndroidName:
          'com.anexon.ethio_cal.MyHomeWidgetDayGlassyProvider',
    );
    await HomeWidget.updateWidget(
      qualifiedAndroidName:
          'com.anexon.ethio_cal.MyHomeWidgetGlassyDarkProvider',
    );
    await HomeWidget.updateWidget(
      qualifiedAndroidName:
          'com.anexon.ethio_cal.MyHomeWidgetDayGlassyDarkProvider',
    );
  }
}
