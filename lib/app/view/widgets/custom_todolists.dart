import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/app/controllers/list_controller.dart';
import 'package:todo_list/app/view/widgets/custom_header_board.dart';

import '../../controllers/list_board_controller.dart';

class CustomTodoLists extends StatefulWidget {
  const CustomTodoLists({Key? key}) : super(key: key);

  @override
  State<CustomTodoLists> createState() => _CustomTodoLists();
}

class InnerList {
  final String name;
  List<String> children;
  ListController listController;
  InnerList({required this.name, required this.children, required this.listController});
}

class _CustomTodoLists extends State<CustomTodoLists> {
  final ListBoardController listBoardController = GetIt.I.get<ListBoardController>();
  late List<InnerList> _lists;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _lists = List.generate(listBoardController.boardsName.length, (outerIndex) {
      print('dmvdlmv');
      final ListController listController = ListController(outerIndex);
        return InnerList(
        name: listBoardController.boardsName[outerIndex].title,
        children: List.generate(listController.tasks.length, (innerIndex) {
          print(listController.tasks[innerIndex].title);
          return listController.tasks[innerIndex].title;
          }
          ),
          listController: listController,
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return DragAndDropLists(
      children: List.generate(_lists.length, (index) => _buildList(index)),
      onItemReorder: _onItemReorder,
      onListReorder: _onListReorder,
      axis: Axis.horizontal,
      listWidth: width * 0.8,
      listDraggingWidth: width * 0.8,
      listPadding: const EdgeInsets.all(8.0),
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
    );
  }

  _buildList(int outerIndex) {
    final InnerList innerList = _lists[outerIndex];
    final ListController listController = innerList.listController;
    return DragAndDropList(
      contentsWhenEmpty: const Text(''),
      header: Observer(
        builder: (context) {
          return CustomHeaderBoard(
            title: innerList.name,
            controller: listController.textEditingController,
            hint: 'Tarefa',
            onChanged: (value) {
              listController.setNewTask(value);
            },
            onTap: listController.addTaskTaped,
          );
        }
      ),
      children: List.generate(innerList.children.length,
          (index) => _buildItem(innerList.children[index])),
    );
  }

  _buildItem(String item) {
    return DragAndDropItem(
      child: ListTile(
        title: Text(item),
      ),
    );
  }

  _onItemReorder(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      final String movedItem = _lists[oldListIndex].children.removeAt(oldItemIndex);
      _lists[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      final InnerList movedList = _lists.removeAt(oldListIndex);
      _lists.insert(newListIndex, movedList);
    });
  }
}