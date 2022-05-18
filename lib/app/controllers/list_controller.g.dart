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

  late final _$isLoadingAtom =
      Atom(name: 'ListControllerBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isTasksObtainedAtom =
      Atom(name: 'ListControllerBase.isTasksObtained', context: context);

  @override
  bool get isTasksObtained {
    _$isTasksObtainedAtom.reportRead();
    return super.isTasksObtained;
  }

  @override
  set isTasksObtained(bool value) {
    _$isTasksObtainedAtom.reportWrite(value, super.isTasksObtained, () {
      super.isTasksObtained = value;
    });
  }

  late final _$addTaskAsyncAction =
      AsyncAction('ListControllerBase.addTask', context: context);

  @override
  Future<void> addTask(int outerIndex) {
    return _$addTaskAsyncAction.run(() => super.addTask(outerIndex));
  }

  late final _$removeTaskAsyncAction =
      AsyncAction('ListControllerBase.removeTask', context: context);

  @override
  Future<void> removeTask(int innerIndex, int outerIndex) {
    return _$removeTaskAsyncAction
        .run(() => super.removeTask(innerIndex, outerIndex));
  }

  late final _$updateTaskAsyncAction =
      AsyncAction('ListControllerBase.updateTask', context: context);

  @override
  Future<void> updateTask(String newTask, int innerIndex, int outerIndex) {
    return _$updateTaskAsyncAction
        .run(() => super.updateTask(newTask, innerIndex, outerIndex));
  }

  late final _$getTasksAsyncAction =
      AsyncAction('ListControllerBase.getTasks', context: context);

  @override
  Future<void> getTasks() {
    return _$getTasksAsyncAction.run(() => super.getTasks());
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
  void toggleIsTasksObtained() {
    final _$actionInfo = _$ListControllerBaseActionController.startAction(
        name: 'ListControllerBase.toggleIsTasksObtained');
    try {
      return super.toggleIsTasksObtained();
    } finally {
      _$ListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addNewKey() {
    final _$actionInfo = _$ListControllerBaseActionController.startAction(
        name: 'ListControllerBase.addNewKey');
    try {
      return super.addNewKey();
    } finally {
      _$ListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeKey(int outerIndex) {
    final _$actionInfo = _$ListControllerBaseActionController.startAction(
        name: 'ListControllerBase.removeKey');
    try {
      return super.removeKey(outerIndex);
    } finally {
      _$ListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
newTask: ${newTask},
isLoading: ${isLoading},
isTasksObtained: ${isTasksObtained},
isNewTaskValid: ${isNewTaskValid}
    ''';
  }
}
