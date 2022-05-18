import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_list/app/controllers/list_controller.dart';

import '../../controllers/list_board_controller.dart';
import 'custom_action_dialog.dart';
import 'custom_header_board.dart';
import 'custom_input_dialog.dart';
import 'custom_pop_menu_buttom.dart';

class CustomTodoLists extends StatefulWidget {
  const CustomTodoLists({ Key? key }) : super(key: key);

  @override
  State<CustomTodoLists> createState() => _CustomTodoListsState();
}

class _CustomTodoListsState extends State<CustomTodoLists> {
  final ListBoardController listBoardController = GetIt.I.get<ListBoardController>();
  final ListController listController = GetIt.I.get<ListController>();

  @override
  void initState() {
    super.initState();
    listController.getTasks();
    
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
            overDragCoefficient: 1.7,
            listWidth: width * 0.8,
            listSizeAnimationDurationMilliseconds: 20,
            listDraggingWidth: width * 0.8,
            listPadding: const EdgeInsets.all(8.0),
            contentsWhenEmpty: const Center(child: Text('Não há quadros')),
            itemDivider: const Divider(height: 0),
            listDecoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(16),
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
              return DragAndDropList(
                contentsWhenEmpty: const Text('Lista vazia'),
                header: CustomHeaderBoard(
                  title: listBoardController.boardsName[outerIndex].title,
                  controller: listController.textEditingController,
                  hint: 'Tarefa',
                  onDelete: () {
                    openActionDialog(
                    title: 'Excluir quadro?',
                    onAccept: () async {
                        await listBoardController.removeBoard(outerIndex);
                        listController.removeKey(outerIndex);
                        setState(() {});
                        Navigator.of(context).pop();
                    });
                  },
                  onChanged: (value) {
                    listController.setNewTask(value);
                  },
                  onTap: listController.isNewTaskValid 
                      ? () {
                          listController.addTask(outerIndex);
                        }
                      : null,
                ),
                children: !listController.isTasksObtained
                ? List.generate(1, (index) => DragAndDropItem(child: const Center(child: CircularProgressIndicator())))
                : List.generate(listController.tasksMap[outerIndex]!.length, (innerIndex) {
                  final String task = listController.tasksMap[outerIndex]?[innerIndex] ?? 'Erro ao encontrar tarefa';
                  return DragAndDropItem(
                    feedbackWidget: Container(
                      child: ListTile(
                        title: Text(task),
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
                    child: ListTile(
                      tileColor: Theme.of(context).scaffoldBackgroundColor,
                      title: Text(task),
                      trailing: CustomPopupMenuButtom(
                        onDelete: () {
                          openActionDialog(
                            title: 'Excluir tarefa?', 
                            onAccept: () async {
                              Navigator.of(context).pop();
                              await listController.removeTask(innerIndex, outerIndex);
                              setState(() {});
                            } 
                          );
                        },
                        onEdit: () {
                          openInputDialog(task, innerIndex, outerIndex);
                        },
                      ),
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
          listController.updateTask(text, innerIndex, outerIndex);
        },

      ),
    );
  }
}