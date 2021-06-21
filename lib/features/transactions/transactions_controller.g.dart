// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TransactionsController on _TransactionsControllerBase, Store {
  final _$loadingStateAtom =
      Atom(name: '_TransactionsControllerBase.loadingState');

  @override
  LoadingState get loadingState {
    _$loadingStateAtom.reportRead();
    return super.loadingState;
  }

  @override
  set loadingState(LoadingState value) {
    _$loadingStateAtom.reportWrite(value, super.loadingState, () {
      super.loadingState = value;
    });
  }

  final _$balanceAtom = Atom(name: '_TransactionsControllerBase.balance');

  @override
  double get balance {
    _$balanceAtom.reportRead();
    return super.balance;
  }

  @override
  set balance(double value) {
    _$balanceAtom.reportWrite(value, super.balance, () {
      super.balance = value;
    });
  }

  final _$_TransactionsControllerBaseActionController =
      ActionController(name: '_TransactionsControllerBase');

  @override
  dynamic setBalance(double d) {
    final _$actionInfo = _$_TransactionsControllerBaseActionController
        .startAction(name: '_TransactionsControllerBase.setBalance');
    try {
      return super.setBalance(d);
    } finally {
      _$_TransactionsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLoadingState(LoadingState l) {
    final _$actionInfo = _$_TransactionsControllerBaseActionController
        .startAction(name: '_TransactionsControllerBase.setLoadingState');
    try {
      return super.setLoadingState(l);
    } finally {
      _$_TransactionsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loadingState: ${loadingState},
balance: ${balance}
    ''';
  }
}
