import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import '../../controllers/list_board_controller.dart';
import '../../controllers/list_controller.dart';
import 'custom_action_dialog.dart';
import 'custom_icon_button.dart';
import 'custom_text_field.dart';

class CustomTaskBoard extends StatefulWidget {
  final String title;
  final int index;
  const CustomTaskBoard({ Key? key, required this.title, required this.index }) : super(key: key);

  @override
  State<CustomTaskBoard> createState() => _CustomTaskBoardState();
}

class _CustomTaskBoardState extends State<CustomTaskBoard> {
  ListController listController = ListController();
  final ListBoardController listBoardController = GetIt.I.get<ListBoardController>();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 22
                              ),
                            ),
                            CustomIconButton(
                              radius: 28,
                              iconData: Icons.delete, 
                              onTap: openInputDialog,
                            )
                          ],
                        ),
                      ),
                      CustomTextField(
                        hint: 'Tarefa',
                        controller: listController.textEditingController,
                        onChanged: listController.setNewTask,
                        suffix: CustomIconButton(
                          radius: 32,
                          iconData: Icons.add,
                          onTap: () {
                            listController.addTaskTaped;
                          },
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
  }

  void openInputDialog() {
    showDialog(
      context: context,
      builder: (_) => CustomActionDialog(
        title: 'Excluir quadro?',
        buttonAcceptText: 'OK',
        buttonCancelText: 'CANCELAR',
        onAccept: () {
          deleteBoard(widget.index);
          Navigator.of(context).pop();
        },
        onCancel: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void deleteBoard(int index) {
    listBoardController.removeBoard(index);
  }
}