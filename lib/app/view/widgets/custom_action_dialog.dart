import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/app/controllers/list_board_controller.dart';

class CustomActionDialog extends StatefulWidget {
  final String title;
  final VoidCallback onAccept;
  final VoidCallback onCancel;
  final String buttonAcceptText;
  final String buttonCancelText;
  const CustomActionDialog({
    Key? key, 
    required this.title, 
    required this.onAccept, 
    required this.onCancel,
    required this.buttonAcceptText,
    required this.buttonCancelText,
    }) : super(key: key);

  @override
  State<CustomActionDialog> createState() => _CustomActionDialogState();
}

class _CustomActionDialogState extends State<CustomActionDialog> {
  final ListBoardController listBoardController = GetIt.I.get<ListBoardController>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      actions: [
        TextButton(
          onPressed: widget.onCancel,
           child: Text(widget.buttonCancelText),
          ),
        TextButton(
          onPressed: widget.onAccept,
           child: Text(widget.buttonAcceptText),
          ),
      ],
    );
  }
}