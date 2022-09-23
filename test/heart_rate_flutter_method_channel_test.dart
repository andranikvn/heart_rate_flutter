import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:heart_rate_flutter/heart_rate_flutter_method_channel.dart';

void main() {
  MethodChannelHeartRateFlutter platform = MethodChannelHeartRateFlutter();
  const MethodChannel channel = MethodChannel('heart_rate_flutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
