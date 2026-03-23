import 'package:ethio_cal/services/ethiopian_date_service.dart';
import 'package:flutter_android_widgets/flutter_android_widgets.dart';

class WidgetService {
  static Future<void> updateHomeWidget() async {
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

    await WidgetUpdater.updateAll();
  }
}
