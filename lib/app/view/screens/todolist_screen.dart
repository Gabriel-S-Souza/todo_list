import 'package:flutter/material.dart';
import '../../controllers/list_board_controller.dart';
import '../../controllers/list_controller.dart';
import '../widgets/custom_task_board_list.dart';
import 'login_screen.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final listController = ListController();
  final ListBoardController listCardController = ListBoardController();

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
                      child: CustomTaskBoardList(),
                    ),
                    IconButton(onPressed: () {
                      listCardController.addCard('Nova lista');
                    }, 
                    icon: const Icon(Icons.add),
                  ),
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