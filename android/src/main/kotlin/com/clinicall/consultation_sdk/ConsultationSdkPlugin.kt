package com.clinicall.consultation_sdk

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.app.PendingIntent
import androidx.core.content.ContextCompat
import android.content.Intent

// for tone
import android.media.ToneGenerator
import android.media.AudioManager
import android.os.Handler
import android.os.Looper
import android.content.Context
import android.telephony.TelephonyManager

/** ConsultationSdkPlugin */
class ConsultationSdkPlugin :
    FlutterPlugin,
    MethodCallHandler {

    private lateinit var channel : MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "test_sdk")
        channel.setMethodCallHandler(this)

        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else if(call.method == "startForegroundService") {
            try {
                val title = call.argument<String>("title") ?: "Ongoing Call"
                val text = call.argument<String>("text") ?: "Call is running"
                val callType = call.argument<String>("call_type") ?: "audio"

                val intent = Intent(context, CallForegroundService::class.java)
                intent.putExtra("title", title)
                intent.putExtra("text", text)
                intent.putExtra(CallForegroundService.EXTRA_CALL_TYPE, callType)
//        startForegroundService(intent)
                context.startForegroundService(intent)
                result.success(null)
            } catch (e: Exception) {
                result.error("$e", "Unable to open startForegroundService", "")
            }
        } else if(call.method == "stopForegroundService") {
            try {
                val intent = Intent(context, CallForegroundService::class.java)
                context.stopService(intent)
                result.success(null)
            } catch (e: Exception) {
                result.error("$e", "Unable to stop stopForegroundService", "")
            }
        } else if (call.method == "startOutgoingCallTone") {
            startOutgoingCallTone();
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else if (call.method == "stopOutgoingCallTone") {
            stopOutgoingCallTone();
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else if (call.method.equals("setEarpiece")) {
            val useEarpiece = call.arguments as Boolean
            setEarpiece(useEarpiece);
            result.success(null);
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }


    // for outgoing tone
    private var toneGenerator: ToneGenerator? = null
    fun startOutgoingCallTone() {
        toneGenerator = ToneGenerator(AudioManager.STREAM_VOICE_CALL, 80)
        toneGenerator?.startTone(ToneGenerator.TONE_SUP_RINGTONE, 30000) // Play for 30 sec
    }

    fun stopOutgoingCallTone() {
        if (toneGenerator != null) {
            toneGenerator?.stopTone()
            toneGenerator?.release()
            toneGenerator = null
        }
    }

    fun setEarpiece(useEarpiece: Boolean){
        val audioManager = context.getSystemService(Context.AUDIO_SERVICE) as AudioManager
        audioManager.mode = AudioManager.MODE_IN_COMMUNICATION
        audioManager.isSpeakerphoneOn = useEarpiece
    }

}
