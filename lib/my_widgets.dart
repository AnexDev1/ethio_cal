import 'package:flutter_android_widgets/flutter_android_widgets.dart';

// Light widget — shows date + day (white background)
final myHomeWidgetProvider = AndroidWidget(
  info: WidgetInfo(
    widgetClassName: 'MyHomeWidgetProvider',
    widgetName: 'Ethiopian Calendar',
    minWidth: 250,
    minHeight: 100,
    updateInterval: const Duration(hours: 1),
    resizeMode: WidgetResizeMode.both,
  ),
  layout: WColumn(
    backgroundColor: '#FFFFFF',
    padding: 16,
    gravity: WGravity.center,
    children: [
      WText(
        r'${ethiopian_date}',
        textSize: 26,
        bold: true,
        textColor: '#1A1A1A',
        gravity: WGravity.center,
      ),
      WText(
        r'${ethiopian_day}',
        textSize: 16,
        textColor: '#666666',
        gravity: WGravity.center,
      ),
    ],
  ),
  dataKeys: const ['ethiopian_date', 'ethiopian_day'],
);

// Dark widget — shows date + day (dark background)
final myHomeWidgetDarkProvider = AndroidWidget(
  info: WidgetInfo(
    widgetClassName: 'MyHomeWidgetDarkProvider',
    widgetName: 'Ethiopian Calendar Dark',
    minWidth: 250,
    minHeight: 100,
    updateInterval: const Duration(hours: 1),
    resizeMode: WidgetResizeMode.both,
  ),
  layout: WColumn(
    backgroundColor: '#2C2C2C',
    padding: 16,
    gravity: WGravity.center,
    children: [
      WText(
        r'${ethiopian_date}',
        textSize: 26,
        bold: true,
        textColor: '#FFFFFF',
        gravity: WGravity.center,
      ),
      WText(
        r'${ethiopian_day}',
        textSize: 16,
        textColor: '#B3B3B3',
        gravity: WGravity.center,
      ),
    ],
  ),
  dataKeys: const ['ethiopian_date', 'ethiopian_day'],
);

// Light day-only widget — shows day name only (white background)
final myHomeWidgetDayProvider = AndroidWidget(
  info: WidgetInfo(
    widgetClassName: 'MyHomeWidgetDayProvider',
    widgetName: 'Ethiopian Calendar Day',
    minWidth: 160,
    minHeight: 80,
    updateInterval: const Duration(hours: 1),
    resizeMode: WidgetResizeMode.both,
  ),
  layout: WColumn(
    backgroundColor: '#FFFFFF',
    padding: 16,
    gravity: WGravity.center,
    children: [
      WText(
        r'${ethiopian_day}',
        textSize: 32,
        bold: true,
        textColor: '#1A1A1A',
        gravity: WGravity.center,
      ),
    ],
  ),
  dataKeys: const ['ethiopian_day'],
);

// Dark day-only widget — shows day name only (dark background)
final myHomeWidgetDayDarkProvider = AndroidWidget(
  info: WidgetInfo(
    widgetClassName: 'MyHomeWidgetDayDarkProvider',
    widgetName: 'Ethiopian Calendar Day Dark',
    minWidth: 160,
    minHeight: 80,
    updateInterval: const Duration(hours: 1),
    resizeMode: WidgetResizeMode.both,
  ),
  layout: WColumn(
    backgroundColor: '#2C2C2C',
    padding: 16,
    gravity: WGravity.center,
    children: [
      WText(
        r'${ethiopian_day}',
        textSize: 32,
        bold: true,
        textColor: '#FFFFFF',
        gravity: WGravity.center,
      ),
    ],
  ),
  dataKeys: const ['ethiopian_day'],
);

// Glassy light widget — shows date + day (semi-transparent white)
final myHomeWidgetGlassyProvider = AndroidWidget(
  info: WidgetInfo(
    widgetClassName: 'MyHomeWidgetGlassyProvider',
    widgetName: 'Ethiopian Calendar Glassy',
    minWidth: 250,
    minHeight: 100,
    updateInterval: const Duration(hours: 1),
    resizeMode: WidgetResizeMode.both,
  ),
  layout: WColumn(
    backgroundColor: '#CCFFFFFF',
    padding: 16,
    gravity: WGravity.center,
    children: [
      WText(
        r'${ethiopian_date}',
        textSize: 26,
        bold: true,
        textColor: '#FFFFFF',
        gravity: WGravity.center,
      ),
      WText(
        r'${ethiopian_day}',
        textSize: 16,
        textColor: '#FFFFFF',
        gravity: WGravity.center,
      ),
    ],
  ),
  dataKeys: const ['ethiopian_date', 'ethiopian_day'],
);

// Glassy dark widget — shows date + day (semi-transparent dark)
final myHomeWidgetGlassyDarkProvider = AndroidWidget(
  info: WidgetInfo(
    widgetClassName: 'MyHomeWidgetGlassyDarkProvider',
    widgetName: 'Ethiopian Calendar Glassy Dark',
    minWidth: 250,
    minHeight: 100,
    updateInterval: const Duration(hours: 1),
    resizeMode: WidgetResizeMode.both,
  ),
  layout: WColumn(
    backgroundColor: '#CC1A1A1A',
    padding: 16,
    gravity: WGravity.center,
    children: [
      WText(
        r'${ethiopian_date}',
        textSize: 26,
        bold: true,
        textColor: '#FFFFFF',
        gravity: WGravity.center,
      ),
      WText(
        r'${ethiopian_day}',
        textSize: 16,
        textColor: '#FFFFFF',
        gravity: WGravity.center,
      ),
    ],
  ),
  dataKeys: const ['ethiopian_date', 'ethiopian_day'],
);

// Glassy day-only widget — shows day name only (semi-transparent white)
final myHomeWidgetDayGlassyProvider = AndroidWidget(
  info: WidgetInfo(
    widgetClassName: 'MyHomeWidgetDayGlassyProvider',
    widgetName: 'Ethiopian Calendar Day Glassy',
    minWidth: 160,
    minHeight: 80,
    updateInterval: const Duration(hours: 1),
    resizeMode: WidgetResizeMode.both,
  ),
  layout: WColumn(
    backgroundColor: '#CCFFFFFF',
    padding: 16,
    gravity: WGravity.center,
    children: [
      WText(
        r'${ethiopian_day}',
        textSize: 26,
        bold: true,
        textColor: '#FFFFFF',
        gravity: WGravity.center,
      ),
    ],
  ),
  dataKeys: const ['ethiopian_day'],
);

// Glassy dark day-only widget — shows day name only (semi-transparent dark)
final myHomeWidgetDayGlassyDarkProvider = AndroidWidget(
  info: WidgetInfo(
    widgetClassName: 'MyHomeWidgetDayGlassyDarkProvider',
    widgetName: 'Ethiopian Calendar Day Glassy Dark',
    minWidth: 160,
    minHeight: 80,
    updateInterval: const Duration(hours: 1),
    resizeMode: WidgetResizeMode.both,
  ),
  layout: WColumn(
    backgroundColor: '#CC1A1A1A',
    padding: 16,
    gravity: WGravity.center,
    children: [
      WText(
        r'${ethiopian_day}',
        textSize: 26,
        bold: true,
        textColor: '#FFFFFF',
        gravity: WGravity.center,
      ),
    ],
  ),
  dataKeys: const ['ethiopian_day'],
);

// Ethiopian progress widget (light glassy)
final progressEthiopianWidgetProvider = AndroidWidget(
  info: WidgetInfo(
    widgetClassName: 'ProgressEthiopianWidgetProvider',
    widgetName: 'Ethiopian Time Progress Light',
    minWidth: 260,
    minHeight: 180,
    updateInterval: const Duration(hours: 1),
    resizeMode: WidgetResizeMode.both,
  ),
  layout: WColumn(
    backgroundColor: '#CCFFFFFF',
    padding: 12,
    gravity: WGravity.start,
    children: [
      WText(
        r'${ethio_day_label}: ${ethio_day_percent}',
        textSize: 14,
        textColor: '#FFFFFF',
      ),
      WText(
        r'${ethio_week_label}: ${ethio_week_percent}',
        textSize: 14,
        textColor: '#FFFFFF',
      ),
      WText(
        r'${ethio_month_label}: ${ethio_month_percent}',
        textSize: 14,
        textColor: '#FFFFFF',
      ),
      WText(
        r'${ethio_year_label}: ${ethio_year_percent}',
        textSize: 14,
        textColor: '#FFFFFF',
      ),
    ],
  ),
  dataKeys: const [
    'ethio_day_label',
    'ethio_day_percent',
    'ethio_day_progress',
    'ethio_week_label',
    'ethio_week_percent',
    'ethio_week_progress',
    'ethio_month_label',
    'ethio_month_percent',
    'ethio_month_progress',
    'ethio_year_label',
    'ethio_year_percent',
    'ethio_year_progress',
  ],
);

// Ethiopian progress widget (dark glassy)
final progressEthiopianDarkWidgetProvider = AndroidWidget(
  info: WidgetInfo(
    widgetClassName: 'ProgressEthiopianWidgetDarkProvider',
    widgetName: 'Ethiopian Time Progress Dark',
    minWidth: 260,
    minHeight: 180,
    updateInterval: const Duration(hours: 1),
    resizeMode: WidgetResizeMode.both,
  ),
  layout: WColumn(
    backgroundColor: '#CC1A1A1A',
    padding: 12,
    gravity: WGravity.start,
    children: [
      WText(
        r'${ethio_day_label}: ${ethio_day_percent}',
        textSize: 14,
        textColor: '#FFFFFF',
      ),
      WText(
        r'${ethio_week_label}: ${ethio_week_percent}',
        textSize: 14,
        textColor: '#FFFFFF',
      ),
      WText(
        r'${ethio_month_label}: ${ethio_month_percent}',
        textSize: 14,
        textColor: '#FFFFFF',
      ),
      WText(
        r'${ethio_year_label}: ${ethio_year_percent}',
        textSize: 14,
        textColor: '#FFFFFF',
      ),
    ],
  ),
  dataKeys: const [
    'ethio_day_label',
    'ethio_day_percent',
    'ethio_day_progress',
    'ethio_week_label',
    'ethio_week_percent',
    'ethio_week_progress',
    'ethio_month_label',
    'ethio_month_percent',
    'ethio_month_progress',
    'ethio_year_label',
    'ethio_year_percent',
    'ethio_year_progress',
  ],
);

// Gregorian progress widget (light glassy)
final progressGregorianWidgetProvider = AndroidWidget(
  info: WidgetInfo(
    widgetClassName: 'ProgressGregorianWidgetProvider',
    widgetName: 'Gregorian Time Progress Light',
    minWidth: 260,
    minHeight: 180,
    updateInterval: const Duration(hours: 1),
    resizeMode: WidgetResizeMode.both,
  ),
  layout: WColumn(
    backgroundColor: '#CCFFFFFF',
    padding: 12,
    gravity: WGravity.start,
    children: [
      WText(
        r'${greg_day_label}: ${greg_day_percent}',
        textSize: 14,
        textColor: '#FFFFFF',
      ),
      WText(
        r'${greg_week_label}: ${greg_week_percent}',
        textSize: 14,
        textColor: '#FFFFFF',
      ),
      WText(
        r'${greg_month_label}: ${greg_month_percent}',
        textSize: 14,
        textColor: '#FFFFFF',
      ),
      WText(
        r'${greg_year_label}: ${greg_year_percent}',
        textSize: 14,
        textColor: '#FFFFFF',
      ),
    ],
  ),
  dataKeys: const [
    'greg_day_label',
    'greg_day_percent',
    'greg_day_progress',
    'greg_week_label',
    'greg_week_percent',
    'greg_week_progress',
    'greg_month_label',
    'greg_month_percent',
    'greg_month_progress',
    'greg_year_label',
    'greg_year_percent',
    'greg_year_progress',
  ],
);

// Gregorian progress widget (dark glassy)
final progressGregorianDarkWidgetProvider = AndroidWidget(
  info: WidgetInfo(
    widgetClassName: 'ProgressGregorianWidgetDarkProvider',
    widgetName: 'Gregorian Time Progress Dark',
    minWidth: 260,
    minHeight: 180,
    updateInterval: const Duration(hours: 1),
    resizeMode: WidgetResizeMode.both,
  ),
  layout: WColumn(
    backgroundColor: '#CC1A1A1A',
    padding: 12,
    gravity: WGravity.start,
    children: [
      WText(
        r'${greg_day_label}: ${greg_day_percent}',
        textSize: 14,
        textColor: '#FFFFFF',
      ),
      WText(
        r'${greg_week_label}: ${greg_week_percent}',
        textSize: 14,
        textColor: '#FFFFFF',
      ),
      WText(
        r'${greg_month_label}: ${greg_month_percent}',
        textSize: 14,
        textColor: '#FFFFFF',
      ),
      WText(
        r'${greg_year_label}: ${greg_year_percent}',
        textSize: 14,
        textColor: '#FFFFFF',
      ),
    ],
  ),
  dataKeys: const [
    'greg_day_label',
    'greg_day_percent',
    'greg_day_progress',
    'greg_week_label',
    'greg_week_percent',
    'greg_week_progress',
    'greg_month_label',
    'greg_month_percent',
    'greg_month_progress',
    'greg_year_label',
    'greg_year_percent',
    'greg_year_progress',
  ],
);

// Ethiopian progress widget (glassy)
final progressEthiopianGlassyWidgetProvider = AndroidWidget(
  info: WidgetInfo(
    widgetClassName: 'ProgressEthiopianWidgetGlassyProvider',
    widgetName: 'Ethiopian Time Progress Glassy',
    minWidth: 260,
    minHeight: 180,
    updateInterval: const Duration(hours: 1),
    resizeMode: WidgetResizeMode.both,
  ),
  layout: WColumn(
    backgroundColor: '#CCFFFFFF',
    padding: 12,
    gravity: WGravity.start,
    children: [
      WText(
        r'${ethio_day_label}: ${ethio_day_percent}',
        textSize: 14,
        textColor: '#1A1A1A',
      ),
      WText(
        r'${ethio_week_label}: ${ethio_week_percent}',
        textSize: 14,
        textColor: '#1A1A1A',
      ),
      WText(
        r'${ethio_month_label}: ${ethio_month_percent}',
        textSize: 14,
        textColor: '#1A1A1A',
      ),
      WText(
        r'${ethio_year_label}: ${ethio_year_percent}',
        textSize: 14,
        textColor: '#1A1A1A',
      ),
    ],
  ),
  dataKeys: const [
    'ethio_day_label',
    'ethio_day_percent',
    'ethio_day_progress',
    'ethio_week_label',
    'ethio_week_percent',
    'ethio_week_progress',
    'ethio_month_label',
    'ethio_month_percent',
    'ethio_month_progress',
    'ethio_year_label',
    'ethio_year_percent',
    'ethio_year_progress',
  ],
);

// Ethiopian progress widget (glassy dark)
final progressEthiopianGlassyDarkWidgetProvider = AndroidWidget(
  info: WidgetInfo(
    widgetClassName: 'ProgressEthiopianWidgetGlassyDarkProvider',
    widgetName: 'Ethiopian Time Progress Glassy Dark',
    minWidth: 260,
    minHeight: 180,
    updateInterval: const Duration(hours: 1),
    resizeMode: WidgetResizeMode.both,
  ),
  layout: WColumn(
    backgroundColor: '#CC1A1A1A',
    padding: 12,
    gravity: WGravity.start,
    children: [
      WText(
        r'${ethio_day_label}: ${ethio_day_percent}',
        textSize: 14,
        textColor: '#FFFFFF',
      ),
      WText(
        r'${ethio_week_label}: ${ethio_week_percent}',
        textSize: 14,
        textColor: '#FFFFFF',
      ),
      WText(
        r'${ethio_month_label}: ${ethio_month_percent}',
        textSize: 14,
        textColor: '#FFFFFF',
      ),
      WText(
        r'${ethio_year_label}: ${ethio_year_percent}',
        textSize: 14,
        textColor: '#FFFFFF',
      ),
    ],
  ),
  dataKeys: const [
    'ethio_day_label',
    'ethio_day_percent',
    'ethio_day_progress',
    'ethio_week_label',
    'ethio_week_percent',
    'ethio_week_progress',
    'ethio_month_label',
    'ethio_month_percent',
    'ethio_month_progress',
    'ethio_year_label',
    'ethio_year_percent',
    'ethio_year_progress',
  ],
);

// Gregorian progress widget (glassy)
final progressGregorianGlassyWidgetProvider = AndroidWidget(
  info: WidgetInfo(
    widgetClassName: 'ProgressGregorianWidgetGlassyProvider',
    widgetName: 'Gregorian Time Progress Glassy',
    minWidth: 260,
    minHeight: 180,
    updateInterval: const Duration(hours: 1),
    resizeMode: WidgetResizeMode.both,
  ),
  layout: WColumn(
    backgroundColor: '#CCFFFFFF',
    padding: 12,
    gravity: WGravity.start,
    children: [
      WText(
        r'${greg_day_label}: ${greg_day_percent}',
        textSize: 14,
        textColor: '#1A1A1A',
      ),
      WText(
        r'${greg_week_label}: ${greg_week_percent}',
        textSize: 14,
        textColor: '#1A1A1A',
      ),
      WText(
        r'${greg_month_label}: ${greg_month_percent}',
        textSize: 14,
        textColor: '#1A1A1A',
      ),
      WText(
        r'${greg_year_label}: ${greg_year_percent}',
        textSize: 14,
        textColor: '#1A1A1A',
      ),
    ],
  ),
  dataKeys: const [
    'greg_day_label',
    'greg_day_percent',
    'greg_day_progress',
    'greg_week_label',
    'greg_week_percent',
    'greg_week_progress',
    'greg_month_label',
    'greg_month_percent',
    'greg_month_progress',
    'greg_year_label',
    'greg_year_percent',
    'greg_year_progress',
  ],
);

// Gregorian progress widget (glassy dark)
final progressGregorianGlassyDarkWidgetProvider = AndroidWidget(
  info: WidgetInfo(
    widgetClassName: 'ProgressGregorianWidgetGlassyDarkProvider',
    widgetName: 'Gregorian Time Progress Glassy Dark',
    minWidth: 260,
    minHeight: 180,
    updateInterval: const Duration(hours: 1),
    resizeMode: WidgetResizeMode.both,
  ),
  layout: WColumn(
    backgroundColor: '#CC1A1A1A',
    padding: 12,
    gravity: WGravity.start,
    children: [
      WText(
        r'${greg_day_label}: ${greg_day_percent}',
        textSize: 14,
        textColor: '#FFFFFF',
      ),
      WText(
        r'${greg_week_label}: ${greg_week_percent}',
        textSize: 14,
        textColor: '#FFFFFF',
      ),
      WText(
        r'${greg_month_label}: ${greg_month_percent}',
        textSize: 14,
        textColor: '#FFFFFF',
      ),
      WText(
        r'${greg_year_label}: ${greg_year_percent}',
        textSize: 14,
        textColor: '#FFFFFF',
      ),
    ],
  ),
  dataKeys: const [
    'greg_day_label',
    'greg_day_percent',
    'greg_day_progress',
    'greg_week_label',
    'greg_week_percent',
    'greg_week_progress',
    'greg_month_label',
    'greg_month_percent',
    'greg_month_progress',
    'greg_year_label',
    'greg_year_percent',
    'greg_year_progress',
  ],
);

/// All widget definitions grouped for use with WidgetUpdater.initialize()
final allWidgets = [
  myHomeWidgetProvider,
  myHomeWidgetDarkProvider,
  myHomeWidgetDayProvider,
  myHomeWidgetDayDarkProvider,
  myHomeWidgetGlassyProvider,
  myHomeWidgetGlassyDarkProvider,
  myHomeWidgetDayGlassyProvider,
  myHomeWidgetDayGlassyDarkProvider,
  progressEthiopianWidgetProvider,
  progressEthiopianDarkWidgetProvider,
  progressEthiopianGlassyWidgetProvider,
  progressEthiopianGlassyDarkWidgetProvider,
  progressGregorianWidgetProvider,
  progressGregorianDarkWidgetProvider,
  progressGregorianGlassyWidgetProvider,
  progressGregorianGlassyDarkWidgetProvider,
];
