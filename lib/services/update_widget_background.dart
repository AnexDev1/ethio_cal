import 'package:ethio_cal/services/widget_service.dart';
import 'package:home_widget/home_widget.dart';

@pragma('vm:entry-point')
Future<void> updateWidgetBackground() async {
  await WidgetService.updateHomeWidget();
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
    qualifiedAndroidName: 'com.anexon.ethio_cal.MyHomeWidgetDayGlassyProvider',
  );
  await HomeWidget.updateWidget(
    qualifiedAndroidName: 'com.anexon.ethio_cal.MyHomeWidgetGlassyDarkProvider',
  );
  await HomeWidget.updateWidget(
    qualifiedAndroidName:
        'com.anexon.ethio_cal.MyHomeWidgetDayGlassyDarkProvider',
  );
}
