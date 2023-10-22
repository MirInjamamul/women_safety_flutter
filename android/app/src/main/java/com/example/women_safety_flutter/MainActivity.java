package com.example.women_safety_flutter;
//import 'dart:typed_data';
//import 'bzip2/bzip2.dart';
//import 'bzip2/bz2_bit_writer.dart';
//import 'util/archive_exception.dart';
//import 'util/byte_order.dart';

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

import android.Manifest;
import android.app.KeyguardManager;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.le.AdvertiseCallback;
import android.bluetooth.le.AdvertiseData;
import android.bluetooth.le.AdvertiseSettings;
import android.bluetooth.le.BluetoothLeAdvertiser;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.ParcelUuid;
import android.util.Log;
import android.widget.Toast;

import com.example.women_safety_flutter.service.PanicService;

import java.nio.charset.StandardCharsets;


public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "safety/panic";

    // BLE Advertising
    private BluetoothAdapter bluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
    private static final AdvertiseSettings settings = new AdvertiseSettings.Builder()
            .setAdvertiseMode(AdvertiseSettings.ADVERTISE_MODE_LOW_LATENCY)
            .setTxPowerLevel(AdvertiseSettings.ADVERTISE_TX_POWER_HIGH)
            .setConnectable(false)
            .build();

    private static final AdvertiseData advertiseData = new AdvertiseData.Builder()
            .setIncludeDeviceName(true)  // Include device name
            .addServiceData(ParcelUuid.fromString("00002a00-0000-1000-8000-00805f9b34fb"), "safety".getBytes(StandardCharsets.UTF_8)) // Add a custom service UUID
            .build();

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler((call, result) -> {
                    if (call.method.equals("startPanicService")) {
                        Log.d("MAIN_ACTIVITY", "Start Service");
                        startService();
                        // Start BLE Advertising
                        startAdvertising();
                    } else if (call.method.equals("stopPanicService")) {
                        Log.d("MAIN_ACTIVITY", "Stop Service");
                        stopService();

                        // Stop Advertise
                        stopAdvertising();
                    }
                });
    }

    private void startService() {
        String input = "Women Safety AID";
        Intent serviceIntent = new Intent(getActivity(), PanicService.class);
        serviceIntent.putExtra("inputExtra", input);

        if (Build.VERSION.SDK_INT >= 26)
            ContextCompat.startForegroundService(this, serviceIntent);
        else
            getContext().startService(serviceIntent);
    }

    private void startAdvertising() {
        if (bluetoothAdapter != null) {
            if (bluetoothAdapter.isMultipleAdvertisementSupported()) {
                BluetoothLeAdvertiser advertiser = bluetoothAdapter.getBluetoothLeAdvertiser();
                if (ActivityCompat.checkSelfPermission(this, Manifest.permission.BLUETOOTH_ADVERTISE) != PackageManager.PERMISSION_GRANTED) {
                    // TODO: Consider calling
                    //    ActivityCompat#requestPermissions
                    // here to request the missing permissions, and then overriding
                    //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
                    //                                          int[] grantResults)
                    // to handle the case where the user grants the permission. See the documentation
                    // for ActivityCompat#requestPermissions for more details.
                    return;
                }
                advertiser.startAdvertising(settings, advertiseData, advertiseCallback);
            }
        } else {
        }
    }

    private void stopAdvertising() {
        if (bluetoothAdapter != null) {
            BluetoothLeAdvertiser advertiser = bluetoothAdapter.getBluetoothLeAdvertiser();
            if (ActivityCompat.checkSelfPermission(this, Manifest.permission.BLUETOOTH_ADVERTISE) != PackageManager.PERMISSION_GRANTED) {
                // TODO: Consider calling
                //    ActivityCompat#requestPermissions
                // here to request the missing permissions, and then overriding
                //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
                //                                          int[] grantResults)
                // to handle the case where the user grants the permission. See the documentation
                // for ActivityCompat#requestPermissions for more details.
                return;
            }
            advertiser.stopAdvertising(advertiseCallback);
        }
    }

    private void stopService() {
        Intent serviceIntent = new Intent(getActivity(), PanicService.class);
        getActivity().stopService(serviceIntent);
    }

    // Advertise Callbacks
    private AdvertiseCallback advertiseCallback = new AdvertiseCallback() {
        @Override
        public void onStartSuccess(AdvertiseSettings settingsInEffect) {
            super.onStartSuccess(settingsInEffect);
            Log.d("ADVERTISE", "onStartSuccess: ");
        }

    };
}