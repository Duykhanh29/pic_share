import 'package:get/get.dart';
import 'package:pic_share/view_model/language/language_controller.dart';

class LanguageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LanguageController>(
      () => LanguageController(),
    );
  }
}
