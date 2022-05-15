import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../controllers/list_controller.dart';
import 'custom_action_dialog.dart';
import 'custom_icon_button.dart';
import 'custom_text_field.dart';

class CustomTaskBoard extends StatefulWidget {
  final String title;
  final int index;
  final void Function(int index) onDelete;
  const CustomTaskBoard({ Key? key, required this.title, required this.index, required this.onDelete }) : super(key: key);

  @override
  State<CustomTaskBoard> createState() => _CustomTaskBoardState();
}

class _CustomTaskBoardState extends State<CustomTaskBoard> {
  late final ListController listController;

  @override
  void initState() {
    super.initState();
    listController = ListController(widget.index);
  }

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
                              onTap: () {
                                openActionDialog(
                                title: 'Excluir quadro?',
                                onCancel: () => print('Cancel'),
                                onAccept: () {
                                  widget.onDelete(widget.index);
                                  Navigator.of(context).pop();
                                });
                              }
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
                              trailing: Transform.translate(
                                offset: const Offset(16, 0),
                                child: PopupMenuButton(
                                  offset: const Offset(-36, 12),
                                  onSelected: (value) {
                                    if (value == DropdownMenuActions.delete) {
                                      
                                      
                                    }
                                  },
                                  itemBuilder: (_) => [
                                    PopupMenuItem(
                                      padding: EdgeInsets.zero,
                                      value: DropdownMenuActions.delete,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 12),
                                        child: Row(
                                          children: const [
                                            Icon(Icons.delete, size: 18),
                                            SizedBox(width: 8,),
                                            Text('Excluir', style: TextStyle(fontSize: 16),),
                                            SizedBox(width: 10),
                                          ],
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      padding: EdgeInsets.zero,
                                      value: DropdownMenuActions.edit,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 12),
                                        child: Row(
                                          children: const [
                                            Icon(Icons.edit, size: 18),
                                            SizedBox(width: 8,),
                                            Text('Editar', style: TextStyle(fontSize: 16),),
                                            SizedBox(width: 10),
                                          ],
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      padding: EdgeInsets.zero,
                                      value: DropdownMenuActions.cancel,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 12),
                                        child: Row(
                                          children: const [
                                            Icon(Icons.backspace_outlined, size: 18),
                                            SizedBox(width: 8,),
                                            Text('Cancelar', style: TextStyle(fontSize: 16),),
                                            SizedBox(width: 10),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
}

enum DropdownMenuActions {
  delete,
  edit,
  cancel,
}