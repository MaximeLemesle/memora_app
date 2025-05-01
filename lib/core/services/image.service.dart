import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  // Pick an image from the gallery
  Future<XFile?> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    return pickedFile;
  }

  // Save image to Firebase Storage
  Future<String> saveImageToFirebaseStorage(XFile image, filePath) async {
    final firebaseStorage = FirebaseStorage.instance;
    File file = File(image.path);

    final bytes = await file.readAsBytes();
    final uploadTask = await firebaseStorage.ref(filePath).putData(
          bytes,
          SettableMetadata(contentType: 'image/jpeg'),
        );
    final downloadUrl = await uploadTask.ref.getDownloadURL();
    return downloadUrl;
  }
}
