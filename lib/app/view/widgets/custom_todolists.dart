import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_list/app/controllers/list_controller.dart';
import 'package:todo_list/app/models/task.dart';
import 'package:todo_list/app/view/widgets/custom_pop_menu_buttom.dart';

import '../../controllers/list_board_controller.dart';
import 'custom_action_dialog.dart';
import 'custom_header_board.dart';
import 'custom_input_dialog.dart';

class CustomTodoLists extends StatefulWidget {
  const CustomTodoLists({ Key? key }) : super(key: key);

  @override
  State<CustomTodoLists> createState() => _CustomTodoListsState();
}

// class InnerList {
//   final String name;
//   final ListController listController;
//   List<String>? children;
//   InnerList({required this.name, required this.listController, this.children});
// }

class _CustomTodoListsState extends State<CustomTodoLists> {
  final ListBoardController listBoardController = GetIt.I.get<ListBoardController>();
  Map<int, ListController> listControllers = {};
  // List<InnerList> _lists = [];

  @override
  void initState() {
    super.initState();
    reaction((_) => !listBoardController.isLoading, (value) {
      for (var i = 0; i < listBoardController.boardsName.length; i++) {
        listControllers[i] = ListController(i);
        listControllers[i]!.getTasks();
      }
      // _lists = List.generate(listBoardController.boardsName.length, (outerIndex) {
      //   ListController listController = ListController(outerIndex);
      //   listController.getTasks();
      //   return InnerList(
      //     name: listBoardController.boardsName[outerIndex].title,
      //     listController: listController,
      //     children: listController.isLoading
      //       ? []
      //       : listController.tasks.map((task) => task.title).toList(),
      //   );
      // });
    });
    //  when(
    //     (_) => listControllers[i]!.isTasksObtained,
    //     () => setState(() {
          
    //     })
    //   );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    
    return Observer(
      builder: (context) {
        if (listBoardController.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        else {
          return DragAndDropLists(
            onItemReorder: _onItemReorder,
            onListReorder: _onListReorder,
            axis: Axis.horizontal,
            listWidth: width * 0.8,
            listDraggingWidth: width * 0.8,
            listPadding: const EdgeInsets.all(8.0),
            contentsWhenEmpty: const Center(child: Text('Não há quadros')),
            listDecoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(7.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black45.withOpacity(0.12),
                  spreadRadius: 3.0,
                  blurRadius: 6.0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            children: List.generate(listBoardController.boardsName.length, (outerIndex) {
              // final ListController listController = _lists[outerIndex].listController;
              // final InnerList innerList = _lists[outerIndex];
              return DragAndDropList(
                contentsWhenEmpty: const Text('Lista vazia'),
                header: CustomHeaderBoard(
                  title: listBoardController.boardsName[outerIndex].title,
                  controller: listControllers[outerIndex]!.textEditingController,
                  hint: 'Tarefa',
                  onChanged: (value) {
                    listControllers[outerIndex]!.setNewTask(value);
                  },
                  onTap: listControllers[outerIndex]!.isNewTaskValid 
                      ? () {
                          listControllers[outerIndex]!.addTask();
                        }
                      : null,
                ),
                children: !listControllers[outerIndex]!.isTasksObtained
                ? List.generate(1, (index) => DragAndDropItem(child: const Center(child: CircularProgressIndicator())))
                : List.generate(listControllers[outerIndex]!.tasks.length, (innerIndex) {
                  return DragAndDropItem(
                    feedbackWidget: Container(
                      child: ListTile(
                        title: Text(listControllers[outerIndex]!.tasks[innerIndex].title),
                        trailing: CustomPopupMenuButtom(onDelete: () {}, onEdit: () {},),
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45.withOpacity(0.12),
                            spreadRadius: 3.0,
                            blurRadius: 6.0,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      ),
                    ),
                    child: Observer(
                      builder: (context) {
                        final String task = listControllers[outerIndex]!.tasks[innerIndex].title;
                        return ListTile(
                          tileColor: Theme.of(context).scaffoldBackgroundColor,
                          title: Text(task),
                          trailing: CustomPopupMenuButtom(
                            onDelete: () {
                              openActionDialog(
                                title: 'Excluir tarefa?', 
                                onAccept: () {
                                  Navigator.of(context).pop();
                                  listControllers[outerIndex]!.removeTask(innerIndex);
                                } 
                              );
                            },
                            onEdit: () {
                              openInputDialog(task, innerIndex, outerIndex);
                            },
                          ),
                        );
                      },
                    ),
                  );
                }
              ),
            );
            })
          );
        }
      }
    );
  }

   _onItemReorder(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      // final String movedItem = _lists[oldListIndex].children!.removeAt(oldItemIndex);
      // _lists[newListIndex].children!.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      // final InnerList movedList = _lists.removeAt(oldListIndex);
      // _lists.insert(newListIndex, movedList);
    });
  }

  void openActionDialog({
    required String title, 
    required void Function() onAccept, 
    void Function()? onCancel
    }) {
    showDialog(
      context: context,
      builder: (_) => CustomActionDialog(
        title: title,
        buttonAcceptText: 'OK',
        buttonCancelText: 'CANCELAR',
        onAccept: onAccept,
        onCancel: onCancel ?? () => Navigator.of(context).pop(),
      ),
    );
  }

  void openInputDialog(String initialTextValue, int innerIndex, int outerIndex) async {
    await showDialog(
      context: context,
      builder: (_) => CustomInputDialog(
        title: 'Editar tarefa',
        hint: 'Tarefa',
        initialTextValue: initialTextValue,
        buttonText: 'OK',
        onSubmit: (text) {
          listControllers[outerIndex]!.updateTask(innerIndex, text);
        },
      ),
    );
  }
}