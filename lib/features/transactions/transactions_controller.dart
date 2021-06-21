import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste_byebnk/features/transactions/GetTransactions.dart';
import 'package:teste_byebnk/model/LoadingState.dart';
import 'package:teste_byebnk/network/api_data_manager.dart';
import 'package:teste_byebnk/network/api_routes.dart';
part 'transactions_controller.g.dart';

class TransactionsController = _TransactionsControllerBase
    with _$TransactionsController;

abstract class _TransactionsControllerBase with Store {
  List<GetTransactions> userTransactions = [];

  @observable
  LoadingState loadingState = LoadingState.NONE;

  @observable
  double balance = 0.0;

  @action
  setBalance(double d) => balance = d;

  @action
  setLoadingState(LoadingState l) => loadingState = l;

  Future getUserTransactions() async {
    setLoadingState(LoadingState.LOADING);
    userTransactions = [];
    var sp = await SharedPreferences.getInstance();
    return ApiDataManager.instance
        .getApi(ApiRoutes.transactions, null, sp.getString("token"))
        .then((value) async {
      if (value is Response) {
        if (value.data["movimentacoes"] != null) {
          if (value.data["movimentacoes"].length > 0) {
            userTransactions = getTransactionsFromJson(
                jsonEncode(value.data["movimentacoes"]));
            getUserAccountBalance();
            setLoadingState(LoadingState.SUCCESS);
          } else {
            setLoadingState(LoadingState.EMPTY);
          }
        } else {
          setLoadingState(LoadingState.EMPTY);
        }
      } else if (value is DioError) {
        setLoadingState(LoadingState.ERROR);
      } else {
        setLoadingState(LoadingState.ERROR);
      }
    });
  }

  getUserAccountBalance() {
    balance = 0.0;
    userTransactions.forEach((element) {
      if (element.tipo == "aplicacao") {
        balance += element.valor;
      } else {
        balance -= element.valor;
      }
    });
  }
}
