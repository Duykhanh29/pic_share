import 'package:flutter/material.dart';
import 'package:pic_share/app/config/home_widget_config.dart';
import 'package:pic_share/app/init_service.dart';
import 'package:pic_share/views/root_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  await HomeWidgetConfig().showUI();
  await HomeWidgetConfig().requestToPinWidget();
  runApp(const RootApp());
}
