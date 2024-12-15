import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  Future<String?> getString(String key) async {
    Box box = Hive.box('main');
    return box.get(key);
  }

  Future<void> setString(String key, String value) async {
    Box box = Hive.box('main');
    await box.put(key, value);
  }

  Future<void> clearAll() async {
    Box box = Hive.box('main');
    await box.clear();
  }
}
