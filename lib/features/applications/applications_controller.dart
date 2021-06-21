import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste_byebnk/model/ApiResult.dart';
import 'package:teste_byebnk/model/LoadingState.dart';
import 'package:teste_byebnk/network/api_data_manager.dart';
import 'package:teste_byebnk/network/api_routes.dart';
import 'package:teste_byebnk/network/api_util.dart';

part 'applications_controller.g.dart';

class ApplicationsController = _ApplicationsControllerBase
    with _$ApplicationsController;

abstract class _ApplicationsControllerBase with Store {
  @observable
  LoadingState loadingState = LoadingState.NONE;

  @action
  setLoadingState(LoadingState l) => loadingState = l;

  @observable
  String applicationValue;

  @action
  setApplicationValue(String s) => applicationValue = s;

  @computed
  bool get canPostApplication {
    if (applicationValue == null) {
      return false;
    }
    if (applicationValue.isEmpty) {
      return false;
    }
    return true;
  }

  //O-> aplicação
  //1-> resgate
  Future<ApiResult> putUserTransactions(int type) async {
    setLoadingState(LoadingState.LOADING);
    var aux = applicationValue.replaceAll(RegExp(r'\.'), '');
    var sendValue = double.parse(aux.replaceAll(RegExp(r','), '.'));
    var sp = await SharedPreferences.getInstance();
    return ApiDataManager.instance
        .putApi(type == 0 ? ApiRoutes.aplicacao : ApiRoutes.resgate,
            {"valor": sendValue}, sp.getString("token"), null)
        .then((value) async {
      if (value is Response) {
        if (value.data["data"] != null) {
          setLoadingState(LoadingState.SUCCESS);
          return ApiResult(message: "Operação bem sucedida", result: true);
        } else {
          setLoadingState(LoadingState.SUCCESS);
          return ApiResult(
              message: "Ocorreu algo inesperado. Tente novamente!",
              result: false);
        }
      } else if (value is DioError) {
        setLoadingState(LoadingState.SUCCESS);
        return ApiResult(
            message: ApiUtil.showNETWORKErrorMessage(value), result: false);
      } else {
        setLoadingState(LoadingState.SUCCESS);
        return ApiResult(
            message: "Ocorreu algo inesperado. Tente novamente!",
            result: false);
      }
    });
  }
}
