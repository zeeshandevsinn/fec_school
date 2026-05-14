import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FilePickerProvider with ChangeNotifier {
  String _fileLink = "";
  Future<String> filePickerFromGallery(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.any, allowCompression: true);
      if (result != null && result.files.single.path != null) {
        File filePath = File(result.files.single.path!);
        _fileLink = filePath.path;
        notifyListeners();
      }
    } catch (e, s) {
      if (kDebugMode) {
        print("object $e $s");
      }
    }

    return _fileLink;
  }
}
