import 'package:mobx/mobx.dart';

part 'task.g.dart';

class Task = TaskBase with _$Task;

abstract class TaskBase with Store {
  TaskBase(this.title);

  final String title;


  //TODO: verificar a necessidade deste campo e de usar MobX nesta classe
  @observable
  bool done = false;

  @action
  void toggleDone() => done = !done;
}