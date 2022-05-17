import 'package:flutter/material.dart';

import 'custom_task_board.dart';

class CustomPopupMenuButtom extends StatelessWidget {
  final Function onDelete;
  final Function onEdit;
  const CustomPopupMenuButtom({
    Key? key, 
    required this.onDelete, 
    required this.onEdit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(16, 0),
      child: PopupMenuButton(
        offset: const Offset(-36, 12),
        onSelected: (value) {
          if (value == DropdownMenuActions.delete) {
            onDelete();
            
          } else if (value == DropdownMenuActions.edit) {
            onEdit();
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
    );
  }
}