// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Task on TaskBase, Store {
  late final _$doneAtom = Atom(name: 'TaskBase.done', context: context);

  @override
  bool get done {
    _$doneAtom.reportRead();
    return super.done;
  }

  @override
  set done(bool value) {
    _$doneAtom.reportWrite(value, super.done, () {
      super.done = value;
    });
  }

  late final _$TaskBaseActionController =
      ActionController(name: 'TaskBase', context: context);

  @override
  void toggleDone() {
    final _$actionInfo =
        _$TaskBaseActionController.startAction(name: 'TaskBase.toggleDone');
    try {
      return super.toggleDone();
    } finally {
      _$TaskBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
done: ${done}
    ''';
  }
}
