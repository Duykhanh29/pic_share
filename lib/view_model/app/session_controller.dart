import 'package:get/get.dart';
import 'package:pic_share/app/services/token_manager.dart';

class SessionController extends GetxController {
  Rx<String?> token = Rx<String?>(null);
  TokenManager tokenManager = TokenManager();

  @override
  void onInit() async {
    super.onInit();
    await fetchToken();
  }

  Future<void> fetchToken() async {
    token.value = await tokenManager.getToken();
  }
}
