import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pic_share/app/constants/strings.dart';
import 'package:pic_share/app/constants/app_images.dart';

class HomeWidgetConfig {
  static Future<String?> update(Widget widget, String url) async {
    try {
      var path = await HomeWidget.renderFlutterWidget(
        widget,
        key: 'filePath',
        logicalSize: const Size(100, 100),
      );
      print("path: $path");
      return path;
      // final data = await FileUtils().getImageBytesFromUrl(url);

      // final directory = await getApplicationSupportDirectory();
      // File tempFile =
      //     File("${directory.path}/${DateTime.now().toIso8601String()}.png");
      // await tempFile.writeAsBytes(data);

      // await HomeWidget.saveWidgetData('filePath', tempFile.path);
      // await HomeWidget.updateWidget(androidName: Strings.androidWidget);
    } catch (e) {
      print("Something went wrong: ${e.toString()}");
    }
    return null;
  }

  Future<void> requestToPinWidget() async {
    final isRequestPinSupported =
        await HomeWidget.isRequestPinWidgetSupported();
    if (isRequestPinSupported == true) {
      await HomeWidget.requestPinWidget(
        androidName: Strings.androidWidget,
      );
    }
  }

  void checkForWidgetLaunch() {
    HomeWidget.initiallyLaunchedFromHomeWidget().then(
      (value) {
        if (value != null) {
          launchedFromWidget(value);
        } else {
          print("null");
        }
      },
    );
  }

  void launchedFromWidget(Uri uri) {
    if (uri != null) {
      print("HERE");
    }
  }

  Future<void> showUI() async {
    await update(
        Image.network(
          "https://i.pinimg.com/736x/9c/14/86/9c1486e3f1f74eeb23d0353cb58382a9.jpg",
          width: 100,
          height: 100,
        ),
        "https://as2.ftcdn.net/v2/jpg/03/06/06/59/1000_F_306065981_FfBRs0qFUMrOqo512YRaa5s8S5pquqT0.jpg");
  }

  Widget image() {
    return Image.asset(AppImage.vietnameFlag);
  }

  Future<File> createFileFromBytes(Uint8List bytes) async {
    // Lấy thư mục lưu trữ tạm
    final directory = await getApplicationSupportDirectory();
    // Tạo một file mới với tên chứa thời gian hiện tại
    final filePath =
        "${directory.path}/${DateTime.now().toIso8601String()}.png";
    final file = File(filePath);

    // Ghi byte dữ liệu vào file
    await file.writeAsBytes(bytes);

    return file;
  }
}
