import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

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
            overDragCoefficient: 1.2,
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
            children: List.generate(listBoardController.boards.length, (outerIndex) {
              final TextEditingController textEditingController = listBoardController.textEditingController;
              return DragAndDropList(
                contentsWhenEmpty: const Text('Lista vazia'),
                header: CustomHeaderBoard(
                  title: listBoardController.boards[outerIndex].title,

                  controller: listBoardController.selectedImputBoard == outerIndex
                      ? textEditingController
                      : TextEditingController(),

                  hint: 'Tarefa',
                  onDelete: () {
                    openActionDialog(
                    title: 'Excluir quadro?',
                    onAccept: () async {
                        await listBoardController.removeBoard(outerIndex);
                        setState(() {});
                        Navigator.of(context).pop();
                    });
                  },
                  onFocusChange: (value) {
                    if (value) {
                      textEditingController.clear();
                      listBoardController.setSelectedImputBoard(null);
                      listBoardController.setSelectedImputBoard(outerIndex);
                    }
                  },
                  onChanged: (value) {
                    listBoardController.setNewTask(value);
                  },
                  onTap: listBoardController.isNewTaskValid && listBoardController.selectedImputBoard == outerIndex
                      ? () {
                          listBoardController.addTask(outerIndex);
                          textEditingController.clear();
                        }
                      : null,
                ),
                children: listBoardController.isLoading
                ? List.generate(1, (index) => DragAndDropItem(child: const Center(child: CircularProgressIndicator())))
                : List.generate(listBoardController.boards[outerIndex].tasks.length, (innerIndex) {
                  final String task = listBoardController.boards[outerIndex].tasks[innerIndex];
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
                              await listBoardController.removeTask(innerIndex, outerIndex);
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
    // setState(() {

    //   String movedTask = listBoardController.boards[oldListIndex].tasks[oldItemIndex];
    //   listBoardController.setNewTask(movedTask);
    //   listBoardController.removeTask(oldItemIndex, oldListIndex);
    //   listBoardController.addTask(newListIndex, newItemIndex);
    // });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    // setState(() {
    //   // final InnerList movedList = _lists.removeAt(oldListIndex);
    //   // _lists.insert(newListIndex, movedList);
    //   if (oldListIndex != newListIndex) {
    //     listController.moveBoard(newListIndex, oldListIndex);
    //   }
    // });
    // Future.delayed(Duration(seconds: 3), () {
    //   listBoardController.moveBoard(newListIndex, oldListIndex);
    // });
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
          listBoardController.updateTask(text, innerIndex, outerIndex);
        },
      ),
    );
  }
}