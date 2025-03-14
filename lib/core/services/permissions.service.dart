import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  // Ask permission to access the photo gallery
  Future<bool> requestGalleryPermission() async {
    final status = await Permission.photos.request();

    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }

    return false;
  }
}
