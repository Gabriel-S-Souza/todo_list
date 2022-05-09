import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final int listCount = 3;
    
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
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
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          clipBehavior: Clip.none,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Align(
                              alignment: Alignment.topCenter,
                              child: Observer(
                                builder: (context) {
                                  return ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxHeight: height * 0.8,
                                    ),
                                    child: Container(
                                      width: width * 0.8,
                                      height: 140 + (listController.tasks.length * 56),
                                      margin: const EdgeInsets.only(left: 16),
                                      child: Card(
                                        clipBehavior: Clip.none,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        elevation: 8,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.only(bottom: 8),
                                                child: Text(
                                                  'Lista $index',
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.w900,
                                                      fontSize: 22
                                                  ),
                                                ),
                                              ),
                                              Observer(
                                                builder: (context) {
                                                  return CustomTextField(
                                                    hint: 'Tarefa',
                                                    controller: listController.textEditingController,
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
                                                child: Observer(
                                                  builder: (context) {
                                                    return ListView.separated(
                                                      shrinkWrap: true,
                                                      itemCount: listController.tasks.length,
                                                      itemBuilder: (_, index){
                                                        final task = listController.tasks[index];
                                    
                                                        return ListTile(
                                                          title: Text(
                                                            task.title,
                                                          ),
                                                        );
                                                      },
                                                      separatorBuilder: (_, __){
                                                        return const Divider(height: 0,);
                                                      },
                                                    );
                                                  }
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              ),
                            );
                          },
                        ),
                      ),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.add),),
                    ],
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