import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/app/view/widgets/custom_header_board.dart';
import 'package:todo_list/app/view/widgets/custom_text_field.dart';

class CustomTodoLists extends StatefulWidget {
  const CustomTodoLists({Key? key}) : super(key: key);

  @override
  State<CustomTodoLists> createState() => _CustomTodoLists();
}

class InnerList {
  final String name;
  List<String> children;
  InnerList({required this.name, required this.children});
}

class _CustomTodoLists extends State<CustomTodoLists> {
  late List<InnerList> _lists;

  @override
  void initState() {
    super.initState();

    _lists = List.generate(9, (outerIndex) {
      return InnerList(
        name: outerIndex.toString(),
        children: List.generate(8, (innerIndex) => '$outerIndex.$innerIndex'),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return DragAndDropLists(
      children: List.generate(_lists.length, (index) => _buildList(index)),
      onItemReorder: _onItemReorder,
      onListReorder: _onListReorder,
      axis: Axis.horizontal,
      listWidth: width * 0.8,
      listDraggingWidth: width * 0.8,
      listPadding: EdgeInsets.all(8.0),
      listDecoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(7.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black45.withOpacity(0.12),
            spreadRadius: 3.0,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
    );
  }

  _buildList(int outerIndex) {
    var innerList = _lists[outerIndex];
    return DragAndDropList(
      // decoration: BoxDecoration(
      //   borderRadius:
      //       BorderRadius.vertical(bottom: Radius.circular(7.0)),
      //   color: Colors.green,
      // ),
      contentsWhenEmpty: const Text(''),
      header: CustomHeaderBoard(
        title: 'Header ${innerList.name}',
    
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

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = _lists[oldListIndex].children.removeAt(oldItemIndex);
      _lists[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = _lists.removeAt(oldListIndex);
      _lists.insert(newListIndex, movedList);
    });
  }
}