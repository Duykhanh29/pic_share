import 'package:camera/camera.dart';
import 'package:pic_share/app/constants/glocal_data.dart';

initServices() async {
  cameras = await availableCameras();
}
