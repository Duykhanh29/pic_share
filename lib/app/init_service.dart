import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/global_data.dart';
import 'package:pic_share/app/services/local_storage_service.dart';
import 'package:pic_share/app/services/location_service.dart';
import 'package:pic_share/app/services/notification_service.dart';

initServices() async {
  await Get.putAsync<LocalStorageService>(LocalStorageService().init,
      permanent: true);
  await Get.putAsync<NotificationsService>(
    NotificationsService().init,
  );
  cameras = await availableCameras();
  Get.lazyPut<LocationService>(() => LocationService());
}
