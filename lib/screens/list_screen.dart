import 'package:flutter/material.dart';
import 'package:todo_list/widgets/custom_list_card.dart';

import '../controllers/list_controller.dart';
import 'login_screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final listController = ListController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Tarefas',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 32
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const LoginScreen())
                      );
                    },
                  ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Flexible(
                      fit: FlexFit.loose,
                      child: CustomListCard(),
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.add),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}