import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/app/view/widgets/custom_input_dialog.dart';
import '../../controllers/list_board_controller.dart';
import '../widgets/custom_todolists.dart';
import 'login_screen.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final ListBoardController listCardController =  GetIt.I.get<ListBoardController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
            const Flexible(
              child: CustomTodoLists(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: openInputDialog,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void openInputDialog() {
    showDialog(
      context: context,
      builder: (_) => CustomInputDialog(
        title: 'Novo quadro',
        hint: 'Nome do quadro',
        onSubmit: (value) async {
            await listCardController.addBoard(value);
        },
        buttonText: 'ADICIONAR',
      ),
    );
  }
}