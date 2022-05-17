import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import '../../controllers/list_board_controller.dart';
import 'custom_task_board.dart';

class CustomTaskBoardList extends StatefulWidget {
  const CustomTaskBoardList({ Key? key }) : super(key: key);

  @override
  State<CustomTaskBoardList> createState() => _CustomTaskBoardListState();
}

class _CustomTaskBoardListState extends State<CustomTaskBoardList> {
  final ListBoardController listBoardController = GetIt.I.get<ListBoardController>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return  Observer(
      builder: (context) {
        if (listBoardController.isLoading) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              child: const CircularProgressIndicator()
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: listBoardController.boardsName.length,
          itemBuilder: (context, index) {
            final String listName = listBoardController.boardsName[index].title;
            return CustomTaskBoard(
              title: listName,
              index: index,
              onDelete: (index) {
                listBoardController.removeBoard(index);
              },
            );
          },
        );
      }
    );
  }
}