package com.clinicall.consultation_sdk

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Context
import android.content.Intent
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.os.Build
import android.os.IBinder
import android.os.PowerManager
import androidx.core.app.NotificationCompat

class CallForegroundService : Service(), SensorEventListener {

    companion object {
        const val CHANNEL_ID = "call_channel"
        const val NOTIFICATION_ID = 1

        const val EXTRA_CALL_TYPE = "call_type"
        const val CALL_TYPE_AUDIO = "audio"
        const val CALL_TYPE_VIDEO = "video"
    }

    private lateinit var sensorManager: SensorManager
    private var proximitySensor: Sensor? = null
    private lateinit var powerManager: PowerManager
    private var wakeLock: PowerManager.WakeLock? = null

    override fun onCreate() {
        super.onCreate()

        // Proximity sensor setup
        sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
        proximitySensor = sensorManager?.getDefaultSensor(Sensor.TYPE_PROXIMITY)
        powerManager = getSystemService(Context.POWER_SERVICE) as PowerManager

        // Fixed: create WakeLock using PowerManager.WakeLock
        // this is old
        try {
            wakeLock = powerManager.newWakeLock(
                PowerManager.PROXIMITY_SCREEN_OFF_WAKE_LOCK,
                "CliniCall:ProximityWakeLock"
            )
        } catch (e: Exception) {
            e.printStackTrace()
            wakeLock = null
        }
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        val title = intent?.getStringExtra("title") ?: "CliniCall"
        val text = intent?.getStringExtra("text") ?: "Calling"
        val callType = intent?.getStringExtra("call_type") ?: "audio"

        createNotificationChannel() // 🆕 added: moved channel creation to a separate method
        val notification: Notification = NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle(title)
            .setContentText(text)
            .setSmallIcon(android.R.drawable.sym_call_incoming)
            .setOngoing(true) // user swipe blocked
            .build()

        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
//                startForegroundService(notification)
            } else {
//                startService(notification)
            }
            startForeground(NOTIFICATION_ID, notification)
        } catch (e: Exception) {
            e.printStackTrace()
        }

        // for audio call only
        if (callType == CALL_TYPE_AUDIO) {
            try {
                proximitySensor?.let {
                    sensorManager?.registerListener(this, it, SensorManager.SENSOR_DELAY_NORMAL)
                }
            } catch (e: Exception) {
                e.printStackTrace()
            }
        } else {
            unregisterProximity() // video হলে sensor বন্ধ
        }

        return START_STICKY
    }

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onDestroy() {
        super.onDestroy()
        unregisterProximity()
        safeReleaseWakeLock()
    }

    // 🆕 added: extracted notification channel creation (for clarity)
    private fun createNotificationChannel() {
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                val manager = getSystemService(NotificationManager::class.java)
                val channel = NotificationChannel(
                    CHANNEL_ID,
                    "Call Service",
                    NotificationManager.IMPORTANCE_LOW
                )
                manager?.createNotificationChannel(channel)
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun safeAcquireWakeLock() {
        try {
            wakeLock?.let {
                if (!it.isHeld) it.acquire(10 * 60 * 1000L) // 🟢 changed: Kotlin safe call + let
            }
//            if (wakeLock != null && wakeLock?.isHeld == false) {
//                wakeLock?.acquire(10 * 60 * 1000L) // 10 min
//            }
        } catch (_: Exception) { }
    }

    private fun safeReleaseWakeLock() {
        try {
            wakeLock?.let {
                if (it.isHeld) it.release() // 🟢 changed: Kotlin safe call + let
            }
//            if (wakeLock != null && wakeLock?.isHeld == true) {
//                wakeLock?.release()
//            }
        } catch (_: Exception) { }
    }

    private fun unregisterProximity() {
        try {
            sensorManager?.unregisterListener(this)
        } catch (_: Exception) { }
        // only release here
        safeReleaseWakeLock()
    }

    // Proximity sensor events
    override fun onSensorChanged(event: SensorEvent?) {
        if (event?.sensor?.type != Sensor.TYPE_PROXIMITY) return
        val distance = event.values[0]
        val max = proximitySensor?.maximumRange ?: 0f
        if (distance < max) {
            safeAcquireWakeLock()
        } else {
            safeReleaseWakeLock()
        }
    }

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {}
}