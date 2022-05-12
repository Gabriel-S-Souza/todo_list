import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CustomInputDialog extends StatefulWidget {
  const CustomInputDialog({ Key? key }) : super(key: key);

  @override
  State<CustomInputDialog> createState() => _CustomInputDialogState();
}

class _CustomInputDialogState extends State<CustomInputDialog> {
  final TextEditingController textEditingController = TextEditingController();
  late final Box box;
  @override
  void initState() {
    super.initState();
    box = Hive.box<String>('task_boards');
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
              box.add(text);
            }
            Navigator.pop(context, textEditingController.text);
          },
           child: const Text('ADICIONAR')
          ),
      ],
    );
  }
}