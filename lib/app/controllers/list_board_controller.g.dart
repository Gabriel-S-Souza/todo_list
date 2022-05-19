// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_board_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ListBoardController on ListBoardControllerBase, Store {
  Computed<bool>? _$isNewTaskValidComputed;

  @override
  bool get isNewTaskValid =>
      (_$isNewTaskValidComputed ??= Computed<bool>(() => super.isNewTaskValid,
              name: 'ListBoardControllerBase.isNewTaskValid'))
          .value;

  late final _$newTaskAtom =
      Atom(name: 'ListBoardControllerBase.newTask', context: context);

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

  late final _$selectedImputBoardAtom = Atom(
      name: 'ListBoardControllerBase.selectedImputBoard', context: context);

  @override
  int? get selectedImputBoard {
    _$selectedImputBoardAtom.reportRead();
    return super.selectedImputBoard;
  }

  @override
  set selectedImputBoard(int? value) {
    _$selectedImputBoardAtom.reportWrite(value, super.selectedImputBoard, () {
      super.selectedImputBoard = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'ListBoardControllerBase.isLoading', context: context);

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

  late final _$addBoardAsyncAction =
      AsyncAction('ListBoardControllerBase.addBoard', context: context);

  @override
  Future<void> addBoard(String value) {
    return _$addBoardAsyncAction.run(() => super.addBoard(value));
  }

  late final _$moveBoardAsyncAction =
      AsyncAction('ListBoardControllerBase.moveBoard', context: context);

  @override
  Future<dynamic> moveBoard(int insertIndex, int oldIndex) {
    return _$moveBoardAsyncAction
        .run(() => super.moveBoard(insertIndex, oldIndex));
  }

  late final _$removeBoardAsyncAction =
      AsyncAction('ListBoardControllerBase.removeBoard', context: context);

  @override
  Future<void> removeBoard(int index) {
    return _$removeBoardAsyncAction.run(() => super.removeBoard(index));
  }

  late final _$_initializeBoardsAsyncAction = AsyncAction(
      'ListBoardControllerBase._initializeBoards',
      context: context);

  @override
  Future<void> _initializeBoards() {
    return _$_initializeBoardsAsyncAction.run(() => super._initializeBoards());
  }

  late final _$_getTasksAsyncAction =
      AsyncAction('ListBoardControllerBase._getTasks', context: context);

  @override
  Future _getTasks() {
    return _$_getTasksAsyncAction.run(() => super._getTasks());
  }

  late final _$addTaskAsyncAction =
      AsyncAction('ListBoardControllerBase.addTask', context: context);

  @override
  Future<void> addTask(int outerIndex, [int? insertIndex]) {
    return _$addTaskAsyncAction
        .run(() => super.addTask(outerIndex, insertIndex));
  }

  late final _$removeTaskAsyncAction =
      AsyncAction('ListBoardControllerBase.removeTask', context: context);

  @override
  Future<void> removeTask(int innerIndex, int outerIndex) {
    return _$removeTaskAsyncAction
        .run(() => super.removeTask(innerIndex, outerIndex));
  }

  late final _$ListBoardControllerBaseActionController =
      ActionController(name: 'ListBoardControllerBase', context: context);

  @override
  void setNewTask(String value) {
    final _$actionInfo = _$ListBoardControllerBaseActionController.startAction(
        name: 'ListBoardControllerBase.setNewTask');
    try {
      return super.setNewTask(value);
    } finally {
      _$ListBoardControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void moveTask(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    final _$actionInfo = _$ListBoardControllerBaseActionController.startAction(
        name: 'ListBoardControllerBase.moveTask');
    try {
      return super
          .moveTask(oldItemIndex, oldListIndex, newItemIndex, newListIndex);
    } finally {
      _$ListBoardControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
newTask: ${newTask},
selectedImputBoard: ${selectedImputBoard},
isLoading: ${isLoading},
isNewTaskValid: ${isNewTaskValid}
    ''';
  }
}
