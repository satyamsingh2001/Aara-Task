import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController{



  File? profile;
  Future<void> pickedProfile(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      profile = File(pickedFile.path);
      update();
    }
  }

}