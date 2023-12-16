// ImageUtility.dart

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ImageUtility {
  static Future<String?> pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      return await _saveImageToLocalDatabase(pickedFile.path);
    }

    return null;
  }

  static Future<String?> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return await _saveImageToLocalDatabase(pickedFile.path);
    }

    return null;
  }

  static Future<String> _saveImageToLocalDatabase(String imagePath) async {
    final database = await _initDatabase();
    final id = await database.insert(
      'ProfileImage',
      {'path': imagePath},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return imagePath;
  }

  static Future<Database> _initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'profile_database.db');

    return openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE IF NOT EXISTS ProfileImage (id INTEGER PRIMARY KEY, path TEXT)",
      );
    });
  }
}
