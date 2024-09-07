import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/glocal_data.dart';
import 'package:pic_share/app/services/local_storage_service.dart';
import 'package:pic_share/app/services/notification_service.dart';

initServices() async {
  await Get.putAsync<LocalStorageService>(LocalStorageService().init,
      permanent: true);
  await Get.putAsync<NotificationsService>(
    () => Future.value(
      NotificationsService(),
    ),
  );
  cameras = await availableCameras();
}
