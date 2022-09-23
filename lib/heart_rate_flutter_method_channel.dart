import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'heart_rate_flutter_platform_interface.dart';

/// An implementation of [HeartRateFlutterPlatform] that uses method channels.
class MethodChannelHeartRateFlutter extends HeartRateFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('heart_rate_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool> init() async {
    var result = await methodChannel.invokeMethod<bool>("init");
    if (result ?? false) {
      methodChannel.setMethodCallHandler(_callHandler);
    }
    return result ?? false;
  }

  Future _callHandler(MethodCall call) async {
    if (call.method == "heart_rate") {
      _controller.add(call.arguments);
    }
  }

  final StreamController<double> _controller = StreamController.broadcast();
  @override
  Stream<double> get heartBeatStream => _controller.stream;
}
