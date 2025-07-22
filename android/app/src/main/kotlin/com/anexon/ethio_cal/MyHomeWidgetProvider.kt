package com.anexon.ethio_cal

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews
import android.content.SharedPreferences

class MyHomeWidgetProvider : AppWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
        // HomeWidget saves data in SharedPreferences named "HomeWidgetPreferences"
        val prefs: SharedPreferences = context.getSharedPreferences("HomeWidgetPreferences", Context.MODE_PRIVATE)
        val date = prefs.getString("ethiopian_date", "...") ?: "..."
        val day = prefs.getString("ethiopian_day", "...") ?: "..."

        for (appWidgetId in appWidgetIds) {
            val options = appWidgetManager.getAppWidgetOptions(appWidgetId)
            val minWidth = options.getInt(AppWidgetManager.OPTION_APPWIDGET_MIN_WIDTH)
            val layoutId = if (minWidth < 180) R.layout.home_widget_compact else R.layout.home_widget
            val views = RemoteViews(context.packageName, layoutId)
            views.setTextViewText(R.id.ethiopian_date, date)
            views.setTextViewText(R.id.ethiopian_day, day)
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
