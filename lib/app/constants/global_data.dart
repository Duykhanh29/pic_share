import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';

late List<CameraDescription> cameras;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
const double singlePostSize = 0.55;
const double radioNewPostView = 0.01;
