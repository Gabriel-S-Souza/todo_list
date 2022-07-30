import 'package:email_validator/email_validator.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_list/app/models/user_login_model.dart';

part 'login_controller.g.dart';

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {

  final UserLoginModel userLoginModel = UserLoginModel();
  
  @observable
  String email = '';

  @action
  void setEmail(String value) => email = value;

  @observable
  String password = '';
  
  @action
  void setPassword(String value) => password = value;

  @observable
  bool passwordVisible = false;

  @action
  void togglePasswordVisible() => passwordVisible = !passwordVisible;

  @computed
  bool get isEmailValid => EmailValidator.validate(email);

  @computed
  bool get isPasswordValid => password.length >= 6;

  @computed
  bool get isFormValid => isEmailValid && isPasswordValid && !loading;

  @observable
  bool loading = false;

  @observable
  bool logged = false;

  @action
  Future<void> login() async {
    loading = true;
    userLoginModel.email = email;
    userLoginModel.password = password;
    await Future.delayed(const Duration(seconds: 2));
    loading = false;
    logged = true;
  }
}