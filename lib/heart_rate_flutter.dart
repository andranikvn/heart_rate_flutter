import 'heart_rate_flutter_platform_interface.dart';

class HeartRateFlutter {
  Future<String?> getPlatformVersion() {
    return HeartRateFlutterPlatform.instance.getPlatformVersion();
  }

  Future<bool> init() {
    return HeartRateFlutterPlatform.instance.init();
  }

  Stream<double> get heartBeatStream =>
      HeartRateFlutterPlatform.instance.heartBeatStream;
}
