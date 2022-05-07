import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:todo_list/widgets/custom_icon_button.dart';
import 'package:todo_list/widgets/custom_text_field.dart';

import '../controllers/list_controller.dart';
import 'login_screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final listController = ListController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: const EdgeInsets.fromLTRB(32, 0, 32, 32),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'Tarefas',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 32
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => const LoginScreen())
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            'A fazer',
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 22
                            ),
                          ),
                        ),
                        Observer(
                          builder: (context) {
                            return CustomTextField(
                              hint: 'Tarefa',
                              onChanged: listController.setNewTask,
                              suffix: CustomIconButton(
                                radius: 32,
                                iconData: Icons.add,
                                onTap: listController.addTaskTaped,
                              ),
                            );
                          }
                        ),
                        const SizedBox(height: 8,),
                        Expanded(
                          child: ListView.separated(
                            itemCount: 10,
                            itemBuilder: (_, index){
                              return ListTile(
                                title: Text(
                                  'Item $index',
                                ),
                                onTap: (){

                                },
                              );
                            },
                            separatorBuilder: (_, __){
                              return const Divider();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}