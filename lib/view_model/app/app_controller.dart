import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppController extends GetxController {
  RxString appVersion = ''.obs;
  RxString buildNumber = ''.obs;
  @override
  void onInit() async {
    appVersion.value = await getVersion();
    buildNumber.value = await getBuildNumber();
    super.onInit();
  }

  Future<String> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  Future<String> getBuildNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.buildNumber;
  }
}
