import 'package:flutter_test/flutter_test.dart';
import 'package:heart_rate_flutter/heart_rate_flutter.dart';
import 'package:heart_rate_flutter/heart_rate_flutter_platform_interface.dart';
import 'package:heart_rate_flutter/heart_rate_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockHeartRateFlutterPlatform
    with MockPlatformInterfaceMixin
    implements HeartRateFlutterPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<bool> init() {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  late Stream<double> heartBeatStream;
}

void main() {
  final HeartRateFlutterPlatform initialPlatform =
      HeartRateFlutterPlatform.instance;

  test('$MethodChannelHeartRateFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelHeartRateFlutter>());
  });

  test('getPlatformVersion', () async {
    HeartRateFlutter heartRateFlutterPlugin = HeartRateFlutter();
    MockHeartRateFlutterPlatform fakePlatform = MockHeartRateFlutterPlatform();
    HeartRateFlutterPlatform.instance = fakePlatform;

    expect(await heartRateFlutterPlugin.getPlatformVersion(), '42');
  });
}
