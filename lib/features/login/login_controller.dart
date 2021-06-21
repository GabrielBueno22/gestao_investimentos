import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste_byebnk/model/ApiResult.dart';
import 'package:teste_byebnk/model/LoadingState.dart';
import 'UserLogin.dart';
import 'package:teste_byebnk/network/api_data_manager.dart';
import 'package:teste_byebnk/network/api_routes.dart';
import 'package:teste_byebnk/network/api_util.dart';
import 'package:teste_byebnk/util/validateUtil.dart';
part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  @observable
  UserLogin userLogin = UserLogin();

  @observable
  LoadingState loadingState = LoadingState.NONE;

  @action
  setLoadingState(LoadingState l) => loadingState = l;

  @computed
  bool get canProceedToLogin {
    if (userLogin.password != null && userLogin.username != null) {
      if (userLogin.password.isNotEmpty &&
          ValidateUtil.isValidEmail(userLogin.username)) {
        return true;
      }
      return false;
    }
    return false;
  }

  Future<ApiResult> postLogin() {
    setLoadingState(LoadingState.LOADING);
    return ApiDataManager.instance
        .postApi(ApiRoutes.login, userLogin.toJson(), null)
        .then((value) async {
      if (value is Response) {
        if (value.data["token"] != null) {
          var sp = await SharedPreferences.getInstance();
          sp.setString("token", value.data["token"]);
          setLoadingState(LoadingState.SUCCESS);
          return ApiResult(message: "Bem vindo", result: true);
        } else {
          setLoadingState(LoadingState.NONE);
          return ApiResult(
              message: "Ocorreu algo inesperado. Tente novamente!",
              result: false);
        }
      } else if (value is DioError) {
        setLoadingState(LoadingState.NONE);
        return ApiResult(
            message: ApiUtil.showNETWORKErrorMessage(value), result: false);
      } else {
        setLoadingState(LoadingState.NONE);
        return ApiResult(
            message: "Ocorreu algo inesperado. Tente novamente!",
            result: false);
      }
    });
  }
}
