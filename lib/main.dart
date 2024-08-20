import 'package:flutter/material.dart';
import 'package:pic_share/app/init_service.dart';
import 'package:pic_share/views/root_app.dart';

void main() async {
  await initServices();
  runApp(const RootApp());
}
