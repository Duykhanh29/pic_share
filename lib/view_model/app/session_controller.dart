import 'package:get/get.dart';
import 'package:pic_share/app/services/token_manager.dart';

class SessionController extends GetxController {
  Rx<String?> token = Rx<String?>(null);
  TokenManager tokenManager = TokenManager();

  @override
  void onInit() {
    super.onInit();
    _loadToken();
  }

  Future<void> _loadToken() async {
    token.value = await tokenManager.getToken();
  }
}
