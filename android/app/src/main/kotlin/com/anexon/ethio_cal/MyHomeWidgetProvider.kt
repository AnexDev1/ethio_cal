package com.anexon.ethio_cal

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews
import android.content.SharedPreferences

import android.content.Intent
import android.content.ComponentName

class MyHomeWidgetProvider : AppWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
        updateAllWidgets(context, appWidgetManager, appWidgetIds)
    }

    override fun onReceive(context: Context, intent: Intent) {
        super.onReceive(context, intent)
        if (intent.action == AppWidgetManager.ACTION_APPWIDGET_UPDATE ||
            intent.action == "android.appwidget.action.APPWIDGET_UPDATE") {
            val appWidgetManager = AppWidgetManager.getInstance(context)
            val thisAppWidget = ComponentName(context.packageName, javaClass.name)
            val appWidgetIds = appWidgetManager.getAppWidgetIds(thisAppWidget)
            updateAllWidgets(context, appWidgetManager, appWidgetIds)
        }
    }

    private fun updateAllWidgets(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
        val prefs: SharedPreferences = context.getSharedPreferences("HomeWidgetPreferences", Context.MODE_PRIVATE)
        val date = prefs.getString("ethiopian_date", "...") ?: "..."
        val day = prefs.getString("ethiopian_day", "...") ?: "..."

        for (appWidgetId in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.home_widget)
            views.setTextViewText(R.id.ethiopian_date, date)
            views.setTextViewText(R.id.ethiopian_day, day)
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
