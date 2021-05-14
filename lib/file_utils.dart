import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileUtils {

  static Future<File> getFile (String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path + fileName;
    return File(path);
  }

  static void saveToFile (String data, String fileName) async {
    final file = await getFile(fileName);
    file.writeAsString(data, mode: FileMode.append);
  }

}