import 'package:flutter/material.dart';

import '../widgets/custom_icon_button.dart';
import '../widgets/custom_input_image.dart';
import '../widgets/custom_text_field.dart';
import 'login_screen.dart';
import 'todolist_screen.dart';

class SinginScreen extends StatefulWidget {
  const SinginScreen({ Key? key }) : super(key: key);

  @override
  State<SinginScreen> createState() => _SinginScreenState();
}

class _SinginScreenState extends State<SinginScreen> {
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
                Text(
                  'Crie uma conta',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
                const Flexible(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomInputImage()
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      CustomTextField(
                        hint: 'Nome',
                        prefix: const Icon(
                          Icons.person,
                        ),
                        onChanged: (value) {},
                        enabled: true, // add flag here
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        hint: 'E-mail',
                        prefix: const Icon(Icons.account_circle),
                        textInputType: TextInputType.emailAddress,
                        onChanged: (value) {},
                        enabled: true, // add flag here
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const   LoginScreen()));
                      },
                      child: Text(
                        'Já possui uma conta? Clique aqui para fazer login.',
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
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const TodoListScreen()));
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}