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

class ProgressEthiopianWidgetProvider : AppWidgetProvider() {

    companion object {
        private const val PREFS_NAME = "FlutterSharedPreferences"
        private const val KEY_PREFIX = "flutter_android_widgets_"
        const val ACTION_REFRESH = "com.anexon.ethio_cal.ProgressEthiopianWidgetProvider.ACTION_REFRESH"
        private const val TOTAL_DOTS = 40        // 20 positions × 2 dots each
        private const val POSITIONS = 20          // number of colon positions
        private const val FILLED_COLOR = "#EEEEEE"
        private const val UNFILLED_COLOR = "#444444"
        private const val DOT_CHAR = "•"          // bullet character for each dot
    }

    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
        for (id in appWidgetIds) updateAppWidget(context, appWidgetManager, id)
    }

    override fun onReceive(context: Context, intent: Intent) {
        super.onReceive(context, intent)
        if (intent.action == ACTION_REFRESH) {
            val mgr = AppWidgetManager.getInstance(context)
            val ids = mgr.getAppWidgetIds(ComponentName(context, ProgressEthiopianWidgetProvider::class.java))
            onUpdate(context, mgr, ids)
        }
    }

    private data class DotRows(val top: CharSequence, val bottom: CharSequence)

    /**
     * Renders 20 positions as two rows of dot characters (top + bottom).
     * Fill order: for each position left-to-right, fill top dot first, then bottom dot.
     * Dot index for position i: top = 2*i, bottom = 2*i + 1.
     * filledCount = floor(percent * 40 / 100), only 100% fills all 40.
     */
    private fun renderDots(progress: Int): DotRows {
        val safeProgress = progress.coerceIn(0, 100)
        val filledCount = if (safeProgress == 100) TOTAL_DOTS else (safeProgress * TOTAL_DOTS) / 100

        val topHtml = StringBuilder()
        val bottomHtml = StringBuilder()

        for (i in 0 until POSITIONS) {
            // Top dot = index 2*i
            val topFilled = (2 * i) < filledCount
            val topColor = if (topFilled) FILLED_COLOR else UNFILLED_COLOR
            topHtml.append("<font color='$topColor'>$DOT_CHAR</font>")

            // Bottom dot = index 2*i + 1
            val bottomFilled = (2 * i + 1) < filledCount
            val bottomColor = if (bottomFilled) FILLED_COLOR else UNFILLED_COLOR
            bottomHtml.append("<font color='$bottomColor'>$DOT_CHAR</font>")
        }

        val top = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            Html.fromHtml(topHtml.toString(), Html.FROM_HTML_MODE_LEGACY)
        } else {
            @Suppress("DEPRECATION") Html.fromHtml(topHtml.toString())
        }
        val bottom = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            Html.fromHtml(bottomHtml.toString(), Html.FROM_HTML_MODE_LEGACY)
        } else {
            @Suppress("DEPRECATION") Html.fromHtml(bottomHtml.toString())
        }

        return DotRows(top, bottom)
    }

    private fun parsePercentText(value: String): Int {
        val numeric = value.trim().removeSuffix("%")
        return numeric.toIntOrNull()?.coerceIn(0, 100) ?: 0
    }

    private fun updateAppWidget(context: Context, appWidgetManager: AppWidgetManager, appWidgetId: Int) {
        val prefs: SharedPreferences = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
        val views = RemoteViews(context.packageName, R.layout.widget_progress_ethiopian)

        fun getString(key: String, fallback: String = "") =
            prefs.getString("flutter.$KEY_PREFIX$key", fallback) ?: fallback

        val dayLabel = getString("ethio_day_label", "DAY")
        val dayPercentText = getString("ethio_day_percent", "0%")
        val weekPercentText = getString("ethio_week_percent", "0%")
        val monthPercentText = getString("ethio_month_percent", "0%")
        val yearPercentText = getString("ethio_year_percent", "0%")

        val dayDots = renderDots(parsePercentText(dayPercentText))
        views.setTextViewText(R.id.text_day, dayLabel)
        views.setTextViewText(R.id.text_day_percent, dayPercentText)
        views.setTextViewText(R.id.dots_day_top, dayDots.top)
        views.setTextViewText(R.id.dots_day_bottom, dayDots.bottom)

        val weekDots = renderDots(parsePercentText(weekPercentText))
        views.setTextViewText(R.id.text_week, getString("ethio_week_label", "WEEK 1"))
        views.setTextViewText(R.id.text_week_percent, weekPercentText)
        views.setTextViewText(R.id.dots_week_top, weekDots.top)
        views.setTextViewText(R.id.dots_week_bottom, weekDots.bottom)

        val monthDots = renderDots(parsePercentText(monthPercentText))
        views.setTextViewText(R.id.text_month, getString("ethio_month_label", "MONTH"))
        views.setTextViewText(R.id.text_month_percent, monthPercentText)
        views.setTextViewText(R.id.dots_month_top, monthDots.top)
        views.setTextViewText(R.id.dots_month_bottom, monthDots.bottom)

        val yearDots = renderDots(parsePercentText(yearPercentText))
        views.setTextViewText(R.id.text_year, getString("ethio_year_label", "YEAR"))
        views.setTextViewText(R.id.text_year_percent, yearPercentText)
        views.setTextViewText(R.id.dots_year_top, yearDots.top)
        views.setTextViewText(R.id.dots_year_bottom, yearDots.bottom)

        appWidgetManager.updateAppWidget(appWidgetId, views)
    }
}
