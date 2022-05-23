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
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(top: width * 0.03, left: 16),
            child: Icon(
              Icons.list_alt,
              size: 32, 
              color: Theme.of(context).textTheme.headline6?.color ?? Colors.black,
            ),
          ),
          leadingWidth: 24,
          toolbarHeight: width * 0.2,
          title: Padding(
            padding: EdgeInsets.only(top: width * 0.03, left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'list.me',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 32,
                      color: Theme.of(context).textTheme.headline6?.color ?? Colors.black,
                      
                  ),
                ),
                Row(
                  children: [
                    
                    Text(
                      '@user',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: Theme.of(context).textTheme.headline6?.color ?? Colors.black,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const CircleAvatar(
                      radius: 14,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),

        body: Column(
          children: const <Widget>[
            Flexible(
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