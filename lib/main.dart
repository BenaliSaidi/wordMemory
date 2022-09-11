import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_words/views/myStats.dart';
import 'package:my_words/views/myWordList.dart';
import 'package:my_words/views/splashScreen.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'model_db/wordModel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  Hive.registerAdapter(MyWordAdapter());

  await Hive.openBox('myWord');

  runApp(const MaterialApp(home: SplashScreen()));
}
