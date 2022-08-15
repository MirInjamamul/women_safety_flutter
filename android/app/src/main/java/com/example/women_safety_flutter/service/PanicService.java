package com.example.women_safety_flutter.service;

import static com.example.women_safety_flutter.App.CHANNEL_ID;

import android.app.Notification;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Build;
import android.os.IBinder;
import android.util.Log;

import androidx.annotation.Nullable;
import androidx.core.app.NotificationCompat;

import com.example.women_safety_flutter.MainActivity;
import com.example.women_safety_flutter.R;
import com.example.women_safety_flutter.receiver.ScreenOnOffReceiver;

public class PanicService extends Service {

    private static final String TAG = "ExampleService";
    ScreenOnOffReceiver screenOnOffReceiver;
    Notification notification;

    @Override
    public void onCreate() {
        super.onCreate();

        //create a IntentFilter instance
        IntentFilter intentFilter = new IntentFilter();

        //add network connectivity change action
        intentFilter.addAction("android.intent.action.SCREEN_ON");
        intentFilter.addAction("android.intent.action.SCREEN_OFF");
        intentFilter.addAction("android.intent.action.PHONE_STATE");
        intentFilter.addAction("android.intent.action.CALL");


        //set broadcast receiver priority
        intentFilter.setPriority(100);

        //Create a network change broadcast receive
        screenOnOffReceiver = new ScreenOnOffReceiver();

        //register the broadcast receiver
        registerReceiver(screenOnOffReceiver,intentFilter);

        Log.d(TAG, "onCreate: Screen on off is registered ");
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        String input = intent.getStringExtra("inputExtra");
        Intent notificationIntent = new Intent(this, MainActivity.class);
        PendingIntent pendingIntent = PendingIntent.getActivity(this,
                0, notificationIntent, 0);

        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.O){
            notification = new NotificationCompat.Builder(this, CHANNEL_ID)
                    .setContentTitle("Women Safety AID")
                    .setContentText(input)
                    .setSmallIcon(R.drawable.launch_background)
                    .setContentIntent(pendingIntent)
                    .build();
            startForeground(1, notification);
        }else{
            NotificationCompat.Builder builder = new NotificationCompat.Builder(this)
                    .setContentTitle("Women Safety AID")
                    .setContentText(input)
                    .setPriority(NotificationCompat.PRIORITY_DEFAULT)
                    .setAutoCancel(true);

            Notification lower_api_notification = builder.build();
            startForeground(1,lower_api_notification);
        }


        //do heavy work on a background thread
        //stopSelf();
        return START_NOT_STICKY;
    }
    @Override
    public void onDestroy() {
        super.onDestroy();

        //unregister screenOnOffReceiver when destroy
        if(screenOnOffReceiver != null){
            unregisterReceiver(screenOnOffReceiver);
            Log.d(TAG, "onDestroy: Receiver is shut down");
        }
    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
}
