import 'package:camera/camera.dart';
import 'package:pic_share/app/constants/glocal_data.dart';
import 'package:pic_share/app/services/notification_service.dart';

initServices() async {
  await NotificationsService().requestPermission();
  await NotificationsService().firebaseNotification();
  cameras = await availableCameras();
}
