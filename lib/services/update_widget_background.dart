import 'package:ethio_cal/services/ethiopian_date_service.dart';
import 'package:flutter_android_widgets/flutter_android_widgets.dart';

// Background alarm callback — only saves data to SharedPreferences.
// The native widget providers read this data on their own update cycle.
@pragma('vm:entry-point')
Future<void> updateWidgetBackground() async {
  final date = EthiopianDateService.getFormattedDate();
  final day = EthiopianDateService.getDayOnly();

  final ethioProgress = EthiopianDateService.getEthiopianProgressData();
  final gregProgress = EthiopianDateService.getGregorianProgressData();

  await HomeWidgetData.saveAll({
    'ethiopian_date': date,
    'ethiopian_day': day,
    ...ethioProgress,
    ...gregProgress,
  });

  // Force widget providers to refresh immediately on the next update cycle.
  await WidgetUpdater.updateAll();
}
