// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ListController on ListControllerBase, Store {
  Computed<bool>? _$isNewTaskValidComputed;

  @override
  bool get isNewTaskValid =>
      (_$isNewTaskValidComputed ??= Computed<bool>(() => super.isNewTaskValid,
              name: 'ListControllerBase.isNewTaskValid'))
          .value;
  Computed<VoidCallback?>? _$addTaskTapedComputed;

  @override
  VoidCallback? get addTaskTaped => (_$addTaskTapedComputed ??=
          Computed<VoidCallback?>(() => super.addTaskTaped,
              name: 'ListControllerBase.addTaskTaped'))
      .value;

  late final _$newTaskAtom =
      Atom(name: 'ListControllerBase.newTask', context: context);

  @override
  String get newTask {
    _$newTaskAtom.reportRead();
    return super.newTask;
  }

  @override
  set newTask(String value) {
    _$newTaskAtom.reportWrite(value, super.newTask, () {
      super.newTask = value;
    });
  }

  late final _$addTaskAsyncAction =
      AsyncAction('ListControllerBase.addTask', context: context);

  @override
  Future<void> addTask() {
    return _$addTaskAsyncAction.run(() => super.addTask());
  }

  late final _$_initializeTasksAsyncAction =
      AsyncAction('ListControllerBase._initializeTasks', context: context);

  @override
  Future<void> _initializeTasks() {
    return _$_initializeTasksAsyncAction.run(() => super._initializeTasks());
  }

  late final _$ListControllerBaseActionController =
      ActionController(name: 'ListControllerBase', context: context);

  @override
  void setNewTask(String value) {
    final _$actionInfo = _$ListControllerBaseActionController.startAction(
        name: 'ListControllerBase.setNewTask');
    try {
      return super.setNewTask(value);
    } finally {
      _$ListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
newTask: ${newTask},
isNewTaskValid: ${isNewTaskValid},
addTaskTaped: ${addTaskTaped}
    ''';
  }
}
