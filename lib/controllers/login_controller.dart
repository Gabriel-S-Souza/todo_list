import 'package:email_validator/email_validator.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  LoginControllerBase() {
    //A função autorun é executada no início e sempre que o valor de algum obervable ou computed mudar. O autorun não precisa
    //necessariamente estar dentro de uma classe como esta para funcionar, podemos adicionar ele em widgets também
    autorun((_) {
      print(isFormValid);
    });
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
    await Future.delayed(const Duration(seconds: 2));
    loading = false;
    logged = true;
  }
}