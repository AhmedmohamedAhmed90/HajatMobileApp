import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:hajat/src/features/app/ui/app.dart';
import 'package:hajat_mobile_app/src/services/locator/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('main');
  setupGetIt();
  // runApp(MyApp());
}
