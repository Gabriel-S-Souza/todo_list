// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_board_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ListBoardController on ListBoardControllerBase, Store {
  late final _$addCardAsyncAction =
      AsyncAction('ListBoardControllerBase.addCard', context: context);

  @override
  Future<void> addCard(String value) {
    return _$addCardAsyncAction.run(() => super.addCard(value));
  }

  late final _$removeCardAsyncAction =
      AsyncAction('ListBoardControllerBase.removeCard', context: context);

  @override
  Future<void> removeCard(int index) {
    return _$removeCardAsyncAction.run(() => super.removeCard(index));
  }

  late final _$ListBoardControllerBaseActionController =
      ActionController(name: 'ListBoardControllerBase', context: context);

  @override
  void _initializeBoards() {
    final _$actionInfo = _$ListBoardControllerBaseActionController.startAction(
        name: 'ListBoardControllerBase._initializeBoards');
    try {
      return super._initializeBoards();
    } finally {
      _$ListBoardControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
