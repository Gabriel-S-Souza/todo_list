// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_board_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ListBoardController on ListBoardControllerBase, Store {
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

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
