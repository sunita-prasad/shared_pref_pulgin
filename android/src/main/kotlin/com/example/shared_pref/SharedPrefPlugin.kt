package com.example.shared_pref

import android.app.Activity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


/** SharedPrefPlugin */
class SharedPrefPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private val methodChannelName = "com.elaunch.shared_pref"
    private var activity: Activity? = null
    private lateinit var channel: MethodChannel
    private lateinit var helper: SharedPrefHelper

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, methodChannelName)
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "getInstance" -> {
                if (activity == null) {
                    return result.error(
                        "ACTIVITY_REQUIRED",
                        "An active activity is required to create shared preference instance",
                        null
                    )
                }
                helper = SharedPrefHelper(activity!!)
                result.success(helper.getAllValues())
            }
            "setValue" -> onValueReceived(call, result)
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    private fun onValueReceived(call: MethodCall, result: Result) {
        val type : String? = call.argument<String>("type")
        val key : String? = call.argument<String>("key")
        val value : Any? = call.argument("value")
        if(type.isNullOrEmpty() || key.isNullOrEmpty())
            return result.error(
                "INVALID_ARGUMENTS", "Invalid arguments passed to method call.", null
            )
        else
            result.success(helper.set(type, key, value))
    }
}
