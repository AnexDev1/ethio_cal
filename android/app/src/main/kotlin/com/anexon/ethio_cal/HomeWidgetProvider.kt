package com.anexon.ethio_cal

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews
import android.content.SharedPreferences

class HomeWidgetProvider : AppWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
        // HomeWidget saves data in SharedPreferences named "HomeWidgetPreferences"
        val prefs: SharedPreferences = context.getSharedPreferences("HomeWidgetPreferences", Context.MODE_PRIVATE)
        val date = prefs.getString("ethiopian_date", "...")
        val day = prefs.getString("ethiopian_day", "...")

        for (appWidgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.home_widget)
            views.setTextViewText(R.id.ethiopian_date, date)
            views.setTextViewText(R.id.ethiopian_day, day)
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
