import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:todo_list/controllers/list_controller.dart';

import 'custom_icon_button.dart';
import 'custom_text_field.dart';

class CustomListCard extends StatefulWidget {
  const CustomListCard({ Key? key }) : super(key: key);

  @override
  State<CustomListCard> createState() => _CustomListCardState();
}

class _CustomListCardState extends State<CustomListCard> {
  ListController listController = ListController();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return  ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: height * 0.8,
            ),
            child: Observer(
              builder: (context) {
                return Container(
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
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              'Lista $index',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 22
                              ),
                            ),
                          ),
                          CustomTextField(
                            hint: 'Tarefa',
                            controller: listController.textEditingController,
                            onChanged: listController.setNewTask,
                            suffix: CustomIconButton(
                              radius: 32,
                              iconData: Icons.add,
                              onTap: listController.addTaskTaped,
                            ),
                          ),
                          const SizedBox(height: 8,),
                          Expanded(
                            child: ListView.separated(
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            ),
          ),
        );
      },
    );
  }
}