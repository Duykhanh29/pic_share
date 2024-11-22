import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class DeviceInfoHelper {
  static Future<String?> getDeviceId() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        return androidInfo.id;
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        return iosInfo.identifierForVendor;
      }
      return null;
    } catch (e, s) {
      debugPrint('Failed to get device id: $e stackTrace: $s');
      return null;
    }
  }

  static Future<String?> getDeviceName() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        return androidInfo.model;
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        return iosInfo.name;
      }
      return null;
    } catch (e, s) {
      debugPrint('Failed to get device name: $e stackTrace: $s');
      return null;
    }
  }
}
