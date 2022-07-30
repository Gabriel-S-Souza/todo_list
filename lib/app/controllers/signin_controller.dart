import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_list/app/controllers/list_board_controller.dart';
import 'package:todo_list/app/services/servicer_locator.dart';

import '../models/user_login_model.dart';
import '../view/screens/todolist_screen.dart';

part 'signin_controller.g.dart';

class SigninController = SigninControllerBase with _$SigninController;

abstract class SigninControllerBase with Store {
  final UserLoginModel userLoginModel = UserLoginModel();

  
  File? imageFilePersist;

  void setImage(File value) {
    saveFile(value);
  }

  @observable
  String email = '';

  @action
  void setEmail(String value) => email = value;

  @observable
  String password = '';
  
  @action
  void setPassword(String value) => password = value;

  @observable
  String name = '';
  
  @action
  void setName(String value) => name = value;

  @observable
  bool passwordVisible = false;

  @action
  void togglePasswordVisible() => passwordVisible = !passwordVisible;

  @computed
  bool get isNameValid => name.isNotEmpty;

  @computed
  bool get isEmailValid => EmailValidator.validate(email);

  @computed
  bool get isPasswordValid => password.length >= 6;

  @computed
  bool get isFormValid => isEmailValid && isPasswordValid && isNameValid;

  @observable
  bool loading = false;

  Future<void> signin(BuildContext context) async{
    loading = true;
    Box box = Hive.box('user_login');

    await box.put('email', email);
    await box.put('password', password);
    await box.put('name', name);
    await box.put('imagePath', imageFilePersist?.path);
    userLoginModel.email = email;
    userLoginModel.password = password;
    userLoginModel.name = name;
    userLoginModel.imagePath = imageFilePersist?.path;

    ListBoardController listBoardController =
        ServiceLocator.getIt.get<ListBoardController>();
    
    listBoardController.userLogin = userLoginModel;

    await Future.delayed(const Duration(seconds: 2));
  
    loading = false;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const TodoListScreen()),
    );
  }

  Future<String> getFilePath() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String appDocumentsPath = appDocumentsDirectory.path;
    String filePath = '$appDocumentsPath/profile';

    return filePath;
  }

  void saveFile(File image) async {
    String filePath = await getFilePath();
    
    imageFilePersist = await image.copy(filePath);
  }

}