// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applications_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ApplicationsController on _ApplicationsControllerBase, Store {
  Computed<bool> _$canPostApplicationComputed;

  @override
  bool get canPostApplication => (_$canPostApplicationComputed ??=
          Computed<bool>(() => super.canPostApplication,
              name: '_ApplicationsControllerBase.canPostApplication'))
      .value;

  final _$loadingStateAtom =
      Atom(name: '_ApplicationsControllerBase.loadingState');

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

  final _$applicationValueAtom =
      Atom(name: '_ApplicationsControllerBase.applicationValue');

  @override
  String get applicationValue {
    _$applicationValueAtom.reportRead();
    return super.applicationValue;
  }

  @override
  set applicationValue(String value) {
    _$applicationValueAtom.reportWrite(value, super.applicationValue, () {
      super.applicationValue = value;
    });
  }

  final _$_ApplicationsControllerBaseActionController =
      ActionController(name: '_ApplicationsControllerBase');

  @override
  dynamic setLoadingState(LoadingState l) {
    final _$actionInfo = _$_ApplicationsControllerBaseActionController
        .startAction(name: '_ApplicationsControllerBase.setLoadingState');
    try {
      return super.setLoadingState(l);
    } finally {
      _$_ApplicationsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setApplicationValue(String s) {
    final _$actionInfo = _$_ApplicationsControllerBaseActionController
        .startAction(name: '_ApplicationsControllerBase.setApplicationValue');
    try {
      return super.setApplicationValue(s);
    } finally {
      _$_ApplicationsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loadingState: ${loadingState},
applicationValue: ${applicationValue},
canPostApplication: ${canPostApplication}
    ''';
  }
}
