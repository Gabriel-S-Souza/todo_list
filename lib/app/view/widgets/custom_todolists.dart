import 'dart:math';

import 'package:confetti/confetti.dart';
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
  late final ConfettiController confettiController;

  @override
  void initState() {
    super.initState();
    confettiController = ConfettiController(duration: const Duration(milliseconds: 70));
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
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
          return Stack(
            children: [
              DragAndDropLists(
                onItemReorder: _onItemReorder,
                onListReorder: _onListReorder,
                axis: Axis.horizontal,
                scrollAreaSize: (width * 0.275).toInt(),
                lastListTargetSize: width * 0.75,
                removeTopPadding: true,
                overDragCoefficient: 1.5,
                listWidth: width * 0.8,
                listSizeAnimationDurationMilliseconds: 20,
                listDraggingWidth: width * 0.8,
                listPadding: const EdgeInsets.only(left: 16, right: 4, top: 16),
                contentsWhenEmpty: const Center(child: Text('Não há quadros')),
                itemDivider: const Divider(height: 0),
                listDecoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black45.withOpacity(0.08),
                      spreadRadius: 3,
                      blurRadius: 6.0,
                      offset: const Offset(0, 2),
                    ),
                    BoxShadow(
                      color: Colors.black45.withOpacity(0.15),
                      blurRadius: 2,
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
              ),
              Align(
                alignment: Alignment.center,
                child: ConfettiWidget(
                  confettiController: confettiController,
                  numberOfParticles: 20,
                  blastDirectionality: BlastDirectionality.explosive,
                  blastDirection: -pi / 2,
                  maxBlastForce: 25,
                  minBlastForce: 18,
                  gravity: 0.16,
                  minimumSize: const Size(5, 5), // set the minimum potential size for the confetti (width, height)
                  maximumSize: const Size(13, 13),
                  colors: const [
                    Colors.white38,
                    Colors.teal,
                    Colors.deepOrange,
                    Colors.blue,
                    Colors.purple
                  ],
                ),
              ),
            ],
          );
        }
      }
    );
  }

   _onItemReorder(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
     if (oldListIndex != newListIndex || oldItemIndex != newItemIndex) {
      setState(() {
        listBoardController.moveTask(oldItemIndex, oldListIndex, newItemIndex, newListIndex);
        if (listBoardController.boards[newListIndex].title == 'Concluído' && oldListIndex != newListIndex) {
          confettiController.play();
        }
      });
     }
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    if (oldListIndex != newListIndex) {
      setState(() {
        listBoardController.moveBoard(newListIndex, oldListIndex);
      });
    }
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