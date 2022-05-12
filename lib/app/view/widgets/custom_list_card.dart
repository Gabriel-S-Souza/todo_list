import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import '../../controllers/list_card_controller.dart';
import 'custom_list.dart';

class CustomListCard extends StatefulWidget {
  const CustomListCard({ Key? key }) : super(key: key);

  @override
  State<CustomListCard> createState() => _CustomListCardState();
}

class _CustomListCardState extends State<CustomListCard> {
  final ListCardController listCardController = GetIt.I.get<ListCardController>();

  //TODO: mock data
  final defaultCardsNames = [
    'A fazer',
    'Fazendo',
    'Concluído',
    'Tarefa 1',
    'Tarefa 2',
    'Tarefa 3',
    'Tarefa 4',
    'Tarefa 5',
  ];

  @override
  void initState() {
    super.initState();
    autorun((_) {
        setState(() {
          
        });
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
            final String listName = listCardController.cardsName[index];
            return CustomList(
              title: listName,
            );
          },
        );
      }
    );
  }
}