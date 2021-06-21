// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserLogin.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserLogin on _UserLoginBase, Store {
  final _$usernameAtom = Atom(name: '_UserLoginBase.username');

  @override
  String get username {
    _$usernameAtom.reportRead();
    return super.username;
  }

  @override
  set username(String value) {
    _$usernameAtom.reportWrite(value, super.username, () {
      super.username = value;
    });
  }

  final _$passwordAtom = Atom(name: '_UserLoginBase.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$_UserLoginBaseActionController =
      ActionController(name: '_UserLoginBase');

  @override
  dynamic setUser(String value) {
    final _$actionInfo = _$_UserLoginBaseActionController.startAction(
        name: '_UserLoginBase.setUser');
    try {
      return super.setUser(value);
    } finally {
      _$_UserLoginBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPassword(String value) {
    final _$actionInfo = _$_UserLoginBaseActionController.startAction(
        name: '_UserLoginBase.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_UserLoginBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
username: ${username},
password: ${password}
    ''';
  }
}
