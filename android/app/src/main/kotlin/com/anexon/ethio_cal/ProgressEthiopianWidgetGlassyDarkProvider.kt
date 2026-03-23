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

class ProgressEthiopianWidgetGlassyDarkProvider : AppWidgetProvider() {

    companion object {
        private const val PREFS_NAME = "FlutterSharedPreferences"
        private const val KEY_PREFIX = "flutter_android_widgets_"
        const val ACTION_REFRESH = "com.anexon.ethio_cal.ProgressEthiopianWidgetGlassyDarkProvider.ACTION_REFRESH"
        private const val TOTAL_DOTS = 40        // 20 positions × 2 dots each
        private const val POSITIONS = 20          // number of colon positions
        private const val FILLED_COLOR = "#FFFFFF"
        private const val UNFILLED_COLOR = "#888888"
        private const val DOT_CHAR = "\u2022"          // bullet character for each dot
    }

    private data class DotRows(val top: CharSequence, val bottom: CharSequence)

    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
        for (id in appWidgetIds) updateAppWidget(context, appWidgetManager, id)
    }

    override fun onReceive(context: Context, intent: Intent) {
        super.onReceive(context, intent)
        if (intent.action == ACTION_REFRESH) {
            val mgr = AppWidgetManager.getInstance(context)
            val ids = mgr.getAppWidgetIds(ComponentName(context, ProgressEthiopianWidgetGlassyDarkProvider::class.java))
            onUpdate(context, mgr, ids)
        }
    }

    private fun renderDots(progress: Int): DotRows {
        val safeProgress = progress.coerceIn(0, 100)
        val filledCount = if (safeProgress == 100) TOTAL_DOTS else (safeProgress * TOTAL_DOTS) / 100

        val topBuilder = StringBuilder()
        val bottomBuilder = StringBuilder()

        for (i in 0 until POSITIONS) {
            val topFilled = (2 * i) < filledCount
            val bottomFilled = (2 * i + 1) < filledCount
            topBuilder.append(if (topFilled) "<font color='$FILLED_COLOR'>$DOT_CHAR</font>" else "<font color='$UNFILLED_COLOR'>$DOT_CHAR</font>")
            bottomBuilder.append(if (bottomFilled) "<font color='$FILLED_COLOR'>$DOT_CHAR</font>" else "<font color='$UNFILLED_COLOR'>$DOT_CHAR</font>")
        }

        val topText = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            Html.fromHtml(topBuilder.toString(), Html.FROM_HTML_MODE_LEGACY)
        } else {
            @Suppress("DEPRECATION") Html.fromHtml(topBuilder.toString())
        }
        val bottomText = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            Html.fromHtml(bottomBuilder.toString(), Html.FROM_HTML_MODE_LEGACY)
        } else {
            @Suppress("DEPRECATION") Html.fromHtml(bottomBuilder.toString())
        }

        return DotRows(top = topText, bottom = bottomText)
    }

    private fun parsePercentText(value: String): Int {
        val numeric = value.trim().removeSuffix("%").trim()
        return numeric.toFloatOrNull()?.toInt()?.coerceIn(0, 100) ?: 0
    }

    private fun updateAppWidget(context: Context, appWidgetManager: AppWidgetManager, appWidgetId: Int) {
        val prefs: SharedPreferences = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
        val views = RemoteViews(context.packageName, R.layout.widget_progress_ethiopian_glassy_dark)

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
        views.setTextViewText(R.id.text_week, getString("ethio_week_label", "ሳምንት 1"))
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
