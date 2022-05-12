import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/app/controllers/list_card_controller.dart';

import 'app/view/my_app.dart';

void main() {
  GetIt getIt = GetIt.I;
  getIt.registerSingleton<ListCardController>(ListCardController());

  runApp(const MyApp());
}