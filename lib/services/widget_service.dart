import 'package:ethio_cal/services/ethiopian_date_service.dart';
import 'package:home_widget/home_widget.dart';

class WidgetService {
  static Future<void> updateHomeWidget() async {
    final date = EthiopianDateService.getFormattedDate();
    final day = EthiopianDateService.getDayOnly();

    await HomeWidget.saveWidgetData<String>('ethiopian_date', date);
    await HomeWidget.saveWidgetData<String>('ethiopian_day', day);

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
