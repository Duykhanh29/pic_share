import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pic_share/app/init_service.dart';
import 'package:pic_share/app/utils/dependencies_injector.dart';
import 'package:pic_share/firebase_options.dart';
import 'package:pic_share/views/root_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await DependenciesInjector.initDependencies();
  await initServices();
  runApp(const RootApp());
}
