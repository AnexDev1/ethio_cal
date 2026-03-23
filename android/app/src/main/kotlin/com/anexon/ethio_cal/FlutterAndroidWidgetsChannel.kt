package com.anexon.ethio_cal

import android.app.Activity
import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

/** Bridges Flutter MethodChannel calls to Android AppWidget broadcasts. */
object FlutterAndroidWidgetsChannel {

    private const val CHANNEL = "flutter_android_widgets"

    private val widgetProviders = listOf<Class<*>>(
        MyHomeWidgetProvider::class.java,
        MyHomeWidgetDarkProvider::class.java,
        MyHomeWidgetGlassyProvider::class.java,
        MyHomeWidgetGlassyDarkProvider::class.java,
        MyHomeWidgetDayProvider::class.java,
        MyHomeWidgetDayDarkProvider::class.java,
        MyHomeWidgetDayGlassyProvider::class.java,
        MyHomeWidgetDayGlassyDarkProvider::class.java,
        ProgressEthiopianWidgetProvider::class.java,
        ProgressGregorianWidgetProvider::class.java
    )

    fun configure(activity: Activity, flutterEngine: FlutterEngine) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "updateAll" -> {
                        updateAll(activity)
                        result.success(null)
                    }
                    "updateWidget" -> {
                        val className = call.argument<String>("widgetName")
                        if (className != null) {
                            updateWidget(activity, className)
                            result.success(null)
                        } else {
                            result.error("INVALID_ARGUMENT", "widgetName is required", null)
                        }
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun updateAll(context: Context) {
        for (provider in widgetProviders) {
            sendUpdate(context, provider)
        }
    }

    private fun updateWidget(context: Context, className: String) {
        val provider = widgetProviders.find { it.simpleName == className }
        if (provider != null) sendUpdate(context, provider)
    }

    private fun sendUpdate(context: Context, provider: Class<*>) {
        val mgr = AppWidgetManager.getInstance(context)
        val ids = mgr.getAppWidgetIds(ComponentName(context, provider))
        if (ids.isNotEmpty()) {
            val intent = Intent(AppWidgetManager.ACTION_APPWIDGET_UPDATE).apply {
                component = ComponentName(context, provider)
                putExtra(AppWidgetManager.EXTRA_APPWIDGET_IDS, ids)
            }
            context.sendBroadcast(intent)
        }
    }
}
