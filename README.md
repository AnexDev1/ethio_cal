# Ethiopian Calendar Flutter App with Android Home Widget

## Overview
This project is a modern Flutter application that displays the Ethiopian date and day, featuring a robust, resizable Android home screen widget. The widget is built using best practices for Android RemoteViews and integrates seamlessly with Flutter using the [home_widget](https://pub.dev/packages/home_widget) plugin.

## Features
- Beautiful, Material 3-inspired Flutter UI
- Animated main screen with Ethiopian date and day
- Android home screen widget:
  - Resizable (width and height)
  - Supports both compact and full layouts
  - Updates dynamically from Flutter
  - Robust resource and XML management
- Clean separation of widget logic and UI

## Project Structure
```
lib/
  main.dart                # Flutter app entry point
  services/
    ethiopian_date_service.dart  # Ethiopian date calculation logic
    widget_service.dart          # Widget update logic (calls HomeWidget plugin)
android/
  app/
    src/main/
      AndroidManifest.xml        # Widget provider and permissions
      kotlin/com/anexon/ethio_cal/
        HomeWidgetProvider.kt    # Android AppWidgetProvider implementation
        MainActivity.kt          # FlutterActivity
      res/
        layout/
          home_widget.xml        # Main widget layout
          home_widget_compact.xml# Compact widget layout
        drawable/                # Widget backgrounds, icons, gradients
        xml/
          home_widget_info.xml   # Widget metadata/configuration
```

## How the Home Widget Works
1. **Flutter Side**
   - Uses the `home_widget` plugin to save data (date, day) to Android SharedPreferences.
   - Calls `HomeWidget.updateWidget()` to trigger a widget update.
   - Handles background updates via `HomeWidget.registerBackgroundCallback`.

2. **Android Side**
   - `HomeWidgetProvider.kt` reads SharedPreferences and updates the widget views.
   - Supports both main and compact layouts, switching based on widget size.
   - All resources (drawables, colors, strings) are defined in XML for compatibility.
   - Widget is fully resizable (see `home_widget_info.xml` for min/max sizes).

## Key Files Explained
- **lib/services/widget_service.dart**: Handles saving widget data and triggering updates from Flutter.
- **android/app/src/main/kotlin/com/anexon/ethio_cal/HomeWidgetProvider.kt**: Reads data and updates the widget. Handles multiple widget sizes.
- **android/app/src/main/res/layout/home_widget.xml**: Main widget layout (RemoteViews-compatible).
- **android/app/src/main/res/layout/home_widget_compact.xml**: Compact layout for small widget sizes.
- **android/app/src/main/res/xml/home_widget_info.xml**: Declares widget metadata, resize support, and preview.
- **android/app/src/main/AndroidManifest.xml**: Registers the widget provider and required permissions.

## Best Practices Used
- All widget resources are split into separate XML files (no multiple XML roots).
- Only RemoteViews-compatible views and attributes are used in widget layouts.
- Widget is fully resizable and adapts layout based on size.
- Null safety and robust error handling in provider code.
- All resources (drawables, strings, colors) are referenced, not hardcoded.

## How to Add/Update the Widget
1. Run the app on an Android device.
2. Add the widget from the launcher’s widget picker.
3. Resize the widget as desired—layout will adapt.
4. Tap the update button in the app to refresh the widget data.

## Customization & Learning
- To add new data to the widget, update `widget_service.dart` and the layouts.
- To support more layouts, add new XML files and update the provider logic.
- To learn more about Android widgets, see the [official documentation](https://developer.android.com/develop/ui/views/appwidgets/overview).

## Troubleshooting
- If the widget does not appear or update, ensure all resources exist and are referenced correctly.
- Only one widget type is supported, but users can add multiple instances (Android limitation).
- Widget layouts must be simple—avoid unsupported views and attributes.

## License
MIT

---

**Built with Flutter, Kotlin, and a love for Ethiopian time!**
