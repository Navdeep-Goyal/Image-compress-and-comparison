import 'dart:developer';
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class GetImageService {
  Future<File> getFile() async {
    final XFile? imageFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxHeight: 200, maxWidth: 200);
    return File(imageFile!.path);
  }
}

class CompressImageService {
  Future<File> imageCropper(File file) async {
    CroppedFile? cropperd = await ImageCropper.platform.cropImage(
      sourcePath: file.path,
      compressQuality: 50,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          lockAspectRatio: true,
          cropGridRowCount: 4,
          cropGridColumnCount: 4,
        ),
      ],
    );
    File croppedfile = File(cropperd!.path);
    log(croppedfile.lengthSync().toString() + "flutter image cropper");
    return croppedfile;
  }

  Future<File> flutterNativeImage(File file) async {
    ImageProperties properties =
        await FlutterNativeImage.getImageProperties(file.path);
    File compressedFile = await FlutterNativeImage.compressImage(file.path,
        quality: 50,
        targetWidth: 600,
        targetHeight: ((properties.height! * 600) / properties.width!).round());
    log(compressedFile.lengthSync().toString() + "native image");
    return compressedFile;
  }

  Future<File> flutterImageCompress(File file) async {
    final directory = await getApplicationDocumentsDirectory();
    File local = await File('${directory.path}/signature.jpg').create();
    log(file.path);
    var result = await FlutterImageCompress.compressAndGetFile(
      file.path,
      local.path,
      quality: 50,
    );

    log(result!.lengthSync().toString() + "image compress");

    log(file.lengthSync().toString());

    return result;
  }
}
