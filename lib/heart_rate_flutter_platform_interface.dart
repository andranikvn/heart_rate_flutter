import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'heart_rate_flutter_method_channel.dart';

abstract class HeartRateFlutterPlatform extends PlatformInterface {
  /// Constructs a HeartRateFlutterPlatform.
  HeartRateFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static HeartRateFlutterPlatform _instance = MethodChannelHeartRateFlutter();

  /// The default instance of [HeartRateFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelHeartRateFlutter].
  static HeartRateFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [HeartRateFlutterPlatform] when
  /// they register themselves.
  static set instance(HeartRateFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool> init() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  late Stream<double> heartBeatStream;
}
