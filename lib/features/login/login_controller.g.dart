// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on _LoginControllerBase, Store {
  Computed<bool> _$canProceedToLoginComputed;

  @override
  bool get canProceedToLogin => (_$canProceedToLoginComputed ??= Computed<bool>(
          () => super.canProceedToLogin,
          name: '_LoginControllerBase.canProceedToLogin'))
      .value;

  final _$userLoginAtom = Atom(name: '_LoginControllerBase.userLogin');

  @override
  UserLogin get userLogin {
    _$userLoginAtom.reportRead();
    return super.userLogin;
  }

  @override
  set userLogin(UserLogin value) {
    _$userLoginAtom.reportWrite(value, super.userLogin, () {
      super.userLogin = value;
    });
  }

  final _$loadingStateAtom = Atom(name: '_LoginControllerBase.loadingState');

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

  final _$_LoginControllerBaseActionController =
      ActionController(name: '_LoginControllerBase');

  @override
  dynamic setLoadingState(LoadingState l) {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction(
        name: '_LoginControllerBase.setLoadingState');
    try {
      return super.setLoadingState(l);
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userLogin: ${userLogin},
loadingState: ${loadingState},
canProceedToLogin: ${canProceedToLogin}
    ''';
  }
}
