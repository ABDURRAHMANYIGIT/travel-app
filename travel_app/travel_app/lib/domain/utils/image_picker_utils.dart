// import 'package:image_cropper/image_cropper.dart';

import 'package:image_picker/image_picker.dart';

class ImagePickerUtils {
  factory ImagePickerUtils() {
    return _imagePickerUtils;
  }

  ImagePickerUtils._();
  static final ImagePickerUtils _imagePickerUtils = ImagePickerUtils._();

  static final ImagePicker _imagePicker = ImagePicker();

  static Future<XFile?> pickImage(ImageSource imageSource) async {
    final XFile? pickedImage = await _imagePicker.pickImage(
        source: imageSource, preferredCameraDevice: CameraDevice.front);
    return pickedImage;
  }
}
