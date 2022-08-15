package com.example.women_safety_flutter;
//import 'dart:typed_data';
//import 'bzip2/bzip2.dart';
//import 'bzip2/bz2_bit_writer.dart';
//import 'util/archive_exception.dart';
//import 'util/byte_order.dart';

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;
import androidx.core.content.ContextCompat;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

import android.app.KeyguardManager;
import android.content.Intent;
import android.os.Build;
import android.util.Log;
import android.widget.Toast;

import com.example.women_safety_flutter.service.PanicService;

public class MainActivity extends FlutterActivity{
    private static final String CHANNEL = "safety/panic";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler((call, result) -> {
                    if (call.method.equals("startPanicService")){
                        Log.d("MAIN_ACTIVITY", "Start Service");
                        startService();
                    }else if (call.method.equals("stopPanicService")){
                        Log.d("MAIN_ACTIVITY", "Stop Service");
                        stopService();
                    }
                });
    }

    private void startService() {
        String input = "Women Safety AID";
        Intent serviceIntent = new Intent(getActivity(), PanicService.class);
        serviceIntent.putExtra("inputExtra", input);

        if(Build.VERSION.SDK_INT >= 26)
            ContextCompat.startForegroundService(this, serviceIntent);
        else
            getContext().startService(serviceIntent);
    }

    private void stopService() {
        Intent serviceIntent = new Intent(getActivity(), PanicService.class);
        getActivity().stopService(serviceIntent);
    }
}