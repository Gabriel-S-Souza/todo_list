import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/app/repositories/hive_app.dart';
import 'package:todo_list/app/services/servicer_locator.dart';
import 'app/models/task_board_model.dart';
import 'app/view/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  Box<TasksBoardModel> box = await HiveApp.init();
  
  ServiceLocator.initDependencies(box);
  
  runApp(const MyApp());
}