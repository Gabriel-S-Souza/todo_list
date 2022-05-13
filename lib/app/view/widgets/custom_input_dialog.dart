import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/app/controllers/list_board_controller.dart';

class CustomInputDialog extends StatefulWidget {
  const CustomInputDialog({ Key? key }) : super(key: key);

  @override
  State<CustomInputDialog> createState() => _CustomInputDialogState();
}

class _CustomInputDialogState extends State<CustomInputDialog> {
  final TextEditingController textEditingController = TextEditingController();
  final ListBoardController listBoardController = GetIt.I.get<ListBoardController>();

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adicionar Novo Quadro'),
      content: TextField(
        controller: textEditingController,
        autofocus: true,
        decoration: const InputDecoration(hintText: 'Nome do Quadro'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (textEditingController.text.isNotEmpty) {
              String text = textEditingController.text;
              listBoardController.addBoard(text);
            }
            Navigator.pop(context);
          },
           child: const Text('ADICIONAR')
          ),
      ],
    );
  }
}