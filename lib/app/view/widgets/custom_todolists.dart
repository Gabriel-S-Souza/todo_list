import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
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
  List<String>? children;
  InnerList({required this.name, this.children});
}

class _CustomTodoLists extends State<CustomTodoLists> {
  final ListBoardController listBoardController = GetIt.I.get<ListBoardController>();
  final ListController listController = GetIt.I.get<ListController>();
  List<InnerList> _lists = [];

  @override
  void initState() {
    super.initState();
    
    reaction((_) => !listBoardController.isLoading, (value) {
      print('rection listBoardController');
      assignList();
      // Future.delayed(Duration(seconds: 4), () {
      //   // assignItens();
      // });
    });

    reaction((_) => !listController.isLoading, (value) {
      print('rection listController');
      assignItens();
    });
  }

  void assignList() {
    _lists = List.generate(listBoardController.boardsName.length, (outerIndex) {
      return InnerList(
        name: listBoardController.boardsName[outerIndex].title,
      );
    }
    );
  }

  void assignItens() {
    int i = 0;
    _lists.map((e) {
      e.children = List.generate(listController.tasks[i]!.length, (index) =>
           listController.tasks[i]![index].title);
           print(e.children);
      i++;
    }).toList();
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
          // print(_lists[0].children);
          return DragAndDropLists(
            onItemReorder: _onItemReorder,
            onListReorder: _onListReorder,
            axis: Axis.horizontal,
            listWidth: width * 0.8,
            listDraggingWidth: width * 0.8,
            listPadding: const EdgeInsets.all(8.0),
            contentsWhenEmpty: const Center(child: Text('Não há quadros')),
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
            children: List.generate(_lists.length, (index) => _buildList(index)),
          );
        }
      }
    );
  }

  _buildList(int outerIndex) {
    final InnerList innerList = _lists[outerIndex];
    listController.read(outerIndex);
    return DragAndDropList(
      contentsWhenEmpty: const Text('Lista vazia'),
      header: CustomHeaderBoard(
          title: innerList.name,
          controller: listController.textEditingController,
          hint: 'Tarefa',
          onChanged: (value) {
            listController.setNewTask(value);
          },
          onTap: listController.isNewTaskValid 
              ? () {
                  listController.addTask(outerIndex);
                }
              : null,
        ),
      children: !listController.isLoading 
      ? List.generate(innerList.children!.length, (index) => _buildItem(innerList.children![index]))
      : List.generate(1, (index) => DragAndDropItem(child: const Center(child: CircularProgressIndicator())))
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
      final String movedItem = _lists[oldListIndex].children!.removeAt(oldItemIndex);
      _lists[newListIndex].children!.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      final InnerList movedList = _lists.removeAt(oldListIndex);
      _lists.insert(newListIndex, movedList);
    });
  }
}