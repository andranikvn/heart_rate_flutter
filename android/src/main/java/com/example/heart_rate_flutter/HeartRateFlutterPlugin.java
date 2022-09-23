package com.example.heart_rate_flutter;

import static android.content.Context.SENSOR_SERVICE;
import static androidx.core.app.ActivityCompat.requestPermissions;
import static androidx.core.content.ContextCompat.checkSelfPermission;
import static androidx.core.content.ContextCompat.getSystemService;

import android.Manifest;
import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Context;
import android.content.pm.PackageManager;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.util.Log;

import androidx.annotation.NonNull;

import java.util.List;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** HeartRateFlutterPlugin */
public class HeartRateFlutterPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware, SensorEventListener {
  final String TAG = "heart_rate_flutter";
  private Activity activity;
  private Context context;

  private MethodChannel channel;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "heart_rate_flutter");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if (call.method.equals("init")) {
      permissionRequest();
      SensorManager mSensorManager = (SensorManager) context.getSystemService(SENSOR_SERVICE);
      @SuppressLint("InlinedApi") Sensor sensor = mSensorManager.getDefaultSensor(Sensor.TYPE_HEART_RATE);

      mSensorManager.registerListener(this, sensor, SensorManager.SENSOR_DELAY_UI);

      result.success(true);
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    context = binding.getActivity().getApplicationContext();
    activity = binding.getActivity();

  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    context = null;
    activity = null;
  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    context = binding.getActivity().getApplicationContext();
    activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivity() {
    context = null;
    activity = null;
  }
  public void permissionRequest(){
    if (checkSelfPermission(context, Manifest.permission.BODY_SENSORS)
            != PackageManager.PERMISSION_GRANTED) {
      requestPermissions(activity,
              new String[]{Manifest.permission.BODY_SENSORS},
              1);
    }
    else{
      Log.d(TAG,"ALREADY GRANTED");
    }
  }

  @Override
  public void onSensorChanged(SensorEvent sensorEvent) {
    channel.invokeMethod("heart_rate", sensorEvent.values[0]);
  }

  @Override
  public void onAccuracyChanged(Sensor sensor, int i) {

  }
}
