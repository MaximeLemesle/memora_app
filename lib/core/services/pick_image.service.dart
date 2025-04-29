import 'package:image_picker/image_picker.dart';

class PickImage {
  // Pick an image from the gallery
  Future<XFile?> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    return pickedFile;
  }
}
