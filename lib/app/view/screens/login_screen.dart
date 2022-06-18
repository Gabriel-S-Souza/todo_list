import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import '../../controllers/login_controller.dart';
import '../widgets/custom_icon_button.dart';
import '../widgets/custom_text_field.dart';
import 'singin_screen.dart';
import 'todolist_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginController = LoginController();

  @override
  void initState() {
    super.initState();
    when((_) => loginController.logged, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const TodoListScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  flex: 3,
                  child: Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Observer(builder: (_) {
                        return CustomTextField(
                          hint: 'E-mail',
                          prefix: const Icon(Icons.account_circle),
                          textInputType: TextInputType.emailAddress,
                          onChanged: loginController.setEmail,
                          enabled: !loginController.loading,
                        );
                      }),
                      const SizedBox(height: 16),
                        Observer(builder: (_) {
                          return CustomTextField(
                            hint: 'Senha',
                            prefix: const Icon(Icons.lock),
                            obscure: !loginController.passwordVisible,
                            onChanged: loginController.setPassword,
                            enabled: !loginController.loading,
                            suffix: CustomIconButton(
                              radius: 32,
                              iconData: loginController.passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              onTap: loginController.togglePasswordVisible,
                            ),
                          );
                        }
                      ),
                      const SizedBox(height: 16),
                      Observer(builder: ((context) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                            primary: Theme.of(context).primaryColor,
                            onSurface: Theme.of(context).primaryColor,
                            textStyle: const TextStyle(color: Colors.white),
                            padding: const EdgeInsets.all(12),
                          ),
                          child: loginController.loading
                              ? SizedBox(
                                height: 17,
                                width: 17,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                                  strokeWidth: 3,
                                ),
                              )
                              : const Text('Login'),
                          onPressed: loginController.isFormValid
                              ? () async {
                                await loginController.login();
                              }
                              : null,
                        );
                      }))
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const   SinginScreen()));
                        },
                        child: Text(
                          'Criar uma conta',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () async {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const TodoListScreen()));
                        },
                        child: Text(
                          'Entrar sem logar',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
