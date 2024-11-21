import 'dart:convert';

import 'package:get/get.dart';
import 'package:pic_share/data/models/user/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum _Key { user, notificationPermission }

class LocalStorageService extends GetxService {
  SharedPreferences? _sharedPreferences;

  Rx<bool> isUserNull = Rx(true);

  Future<LocalStorageService> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  UserModel? get userModel {
    final rawJson = _sharedPreferences?.getString(_Key.user.toString());
    if (rawJson == null) {
      isUserNull.value = true;
      return null;
    }
    Map<String, dynamic> map = jsonDecode(rawJson);
    isUserNull.value = false;
    return UserModel.fromJson(map);
  }

  void setUserModel({UserModel? value, bool isUpdateUserNull = true}) {
    if (value != null) {
      _sharedPreferences?.setString(
          _Key.user.toString(), json.encode(value.toJson()));
      if (isUpdateUserNull) {
        isUserNull.value = false;
      }
    } else {
      if (isUpdateUserNull) {
        isUserNull.value = true;
      }

      _sharedPreferences?.remove(_Key.user.toString());
    }
  }

  String? get language {
    return userModel?.config?.language;
  }

  set setLanguage(String? value) {
    if (value != null) {
      setUserModel(
          value: userModel?.copyWith(
              config: userModel?.config?.copyWith(language: value)),
          isUpdateUserNull: false);
    }
  }

  void setIsEnable2Fa(bool value) {
    setUserModel(
      value: userModel?.copyWith(isEnable2FA: value),
    );
  }

  void setNotificationPermission(bool value) {
    _sharedPreferences?.setBool(_Key.notificationPermission.toString(), value);
  }

  bool get notificationPermission {
    return _sharedPreferences
            ?.getBool(_Key.notificationPermission.toString()) ??
        false;
  }

  void removeAllSharedPreferencesValues() {
    for (var element in _Key.values) {
      _sharedPreferences?.remove(element.toString());
    }
    isUserNull.value = true;
  }
}
