import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../widgets/custom_icon_button.dart';
import '../widgets/custom_text_field.dart';
import 'login_screen.dart';
import 'todolist_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({ Key? key }) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
                      'Cadastre-se',
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
                      CustomTextField(
                        hint: 'E-mail',
                        prefix: const Icon(Icons.account_circle),
                        textInputType: TextInputType.emailAddress,
                        onChanged: (value) {},
                        enabled: true, // add flag here
                      ),
                      const SizedBox(height: 16),
                        Observer(builder: (_) {
                          return CustomTextField(
                            hint: 'Senha',
                            prefix: const Icon(Icons.lock),
                            obscure: false, // add flag here
                            onChanged: (value) {},
                            enabled: true, // add flag here
                            suffix: CustomIconButton(
                              radius: 32,
                              iconData: true
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              onTap: () {},
                            ),
                          );
                        }
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          primary: Theme.of(context).primaryColor,
                          onSurface: Theme.of(context).primaryColor,
                          textStyle: const TextStyle(color: Colors.white),
                          padding: const EdgeInsets.all(12),
                        ),
                        child: false
                            ? SizedBox(
                              height: 17,
                              width: 17,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                                strokeWidth: 3,
                              ),
                            )
                            : const Text('Cadastrar'),
                        onPressed: null, // add flag here for disable button
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const   LoginScreen()));
                        },
                        child: const Text('Já possui uma conta? Clique aqui para fazer login.'),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const TodoListScreen()));
                        },
                        child: const Text('Entrar sem logar'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}