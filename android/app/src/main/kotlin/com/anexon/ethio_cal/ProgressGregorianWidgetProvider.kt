package com.anexon.ethio_cal

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.os.Build
import android.text.Html
import android.widget.RemoteViews

class ProgressGregorianWidgetProvider : AppWidgetProvider() {

    companion object {
        private const val PREFS_NAME = "FlutterSharedPreferences"
        private const val KEY_PREFIX = "flutter_android_widgets_"
        const val ACTION_REFRESH = "com.anexon.ethio_cal.ProgressGregorianWidgetProvider.ACTION_REFRESH"
    }

    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
        for (id in appWidgetIds) updateAppWidget(context, appWidgetManager, id)
    }

    override fun onReceive(context: Context, intent: Intent) {
        super.onReceive(context, intent)
        if (intent.action == ACTION_REFRESH) {
            val mgr = AppWidgetManager.getInstance(context)
            val ids = mgr.getAppWidgetIds(ComponentName(context, ProgressGregorianWidgetProvider::class.java))
            onUpdate(context, mgr, ids)
        }
    }

    private fun renderDots(progress: Int): CharSequence {
        val totalDots = 32
        val p = (progress.coerceIn(0, 100)) / 100f
        val filledCount = (totalDots * p).toInt()
        val unfilledCount = totalDots - filledCount
        val filled = ":".repeat(filledCount)
        val unfilled = ":".repeat(unfilledCount)
        val html = "<font color='#D9D9D9'>$filled</font><font color='#4A4A4A'>$unfilled</font>"
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            Html.fromHtml(html, Html.FROM_HTML_MODE_LEGACY)
        } else {
            @Suppress("DEPRECATION") Html.fromHtml(html)
        }
    }

    private fun updateAppWidget(context: Context, appWidgetManager: AppWidgetManager, appWidgetId: Int) {
        val prefs: SharedPreferences = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
        val views = RemoteViews(context.packageName, R.layout.widget_progress_gregorian)

        fun getString(key: String, fallback: String = "") =
            prefs.getString("flutter.$KEY_PREFIX$key", fallback) ?: fallback

        fun getInt(key: String, fallback: Int = 0) =
            prefs.getString("flutter.$KEY_PREFIX$key", fallback.toString())?.toIntOrNull() ?: fallback

        val dayLabel = getString("greg_day_label", "DAY")
        views.setTextViewText(R.id.text_day, dayLabel)
        views.setTextViewText(R.id.text_day_percent, getString("greg_day_percent", "0%"))
        views.setTextViewText(R.id.dots_day, renderDots(getInt("greg_day_progress", 0)))

        views.setTextViewText(R.id.text_week, getString("greg_week_label", "WEEK 1"))
        views.setTextViewText(R.id.text_week_percent, getString("greg_week_percent", "0%"))
        views.setTextViewText(R.id.dots_week, renderDots(getInt("greg_week_progress", 0)))

        views.setTextViewText(R.id.text_month, getString("greg_month_label", "MONTH"))
        views.setTextViewText(R.id.text_month_percent, getString("greg_month_percent", "0%"))
        views.setTextViewText(R.id.dots_month, renderDots(getInt("greg_month_progress", 0)))

        views.setTextViewText(R.id.text_year, getString("greg_year_label", "YEAR"))
        views.setTextViewText(R.id.text_year_percent, getString("greg_year_percent", "0%"))
        views.setTextViewText(R.id.dots_year, renderDots(getInt("greg_year_progress", 0)))

        appWidgetManager.updateAppWidget(appWidgetId, views)
    }
}



