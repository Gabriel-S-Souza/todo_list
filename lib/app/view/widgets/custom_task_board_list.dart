import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import '../../controllers/list_board_controller.dart';
import 'custom_task_board.dart';

class CustomTaskBoardList extends StatefulWidget {
  const CustomTaskBoardList({ Key? key }) : super(key: key);

  @override
  State<CustomTaskBoardList> createState() => _CustomTaskBoardListState();
}

class _CustomTaskBoardListState extends State<CustomTaskBoardList> {
  final ListBoardController listCardController = GetIt.I.get<ListBoardController>();
  late Box<String> box;
  @override
  void initState() {
    super.initState();
    box = Hive.box<String>('task_boards');
    box.values.map((value) {
      listCardController.addCard(value);
    }).toList();

    reaction((_) => listCardController.cardsName, (value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {

    return  Observer(
      builder: (context) {
        return ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: listCardController.cardsName.length,
          itemBuilder: (context, index) {
            final String listName = listCardController.cardsName[index].title;
            return CustomTaskBoard(
              title: listName,
            );
          },
        );
      }
    );
  }
}