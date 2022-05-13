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
  final ListBoardController listBoardController = GetIt.I.get<ListBoardController>();
  final List<String> boards = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return  Observer(
      builder: (context) {
        return ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: listBoardController.cardsName.length,
          itemBuilder: (context, index) {
            final String listName = listBoardController.cardsName[index].title;
            return CustomTaskBoard(
              title: listName,
            );
          },
        );
      }
    );
  }
}