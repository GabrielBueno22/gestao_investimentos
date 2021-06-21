import 'package:dio/dio.dart';
import 'api_helper.dart';

class ApiDataManager {
  ApiHelper _apiBaseHelper = ApiHelper.instance;
  ApiDataManager._privateConstructor();
  static final ApiDataManager instance = ApiDataManager._privateConstructor();

  //Métodos POST, GET, PUT, e FORMDATA

  Future<dynamic> postApi(
      String route, Map<String, dynamic> body, String token) async {
    try {
      print(body);
      Dio dio = await _apiBaseHelper.getDio();
      dio.options.headers['Content-Type'] = 'application/json;charset=UTF-8';
      if (token != null) {
        dio.options.headers["Authorization"] = token;
      }

      Response response = await dio.post(route, data: body);
      return response;
    } on DioError catch (e) {
      return e;
    }
  }

  Future getApi(
      String route, Map<String, dynamic> queryParameters, String token) async {
    try {
      Dio dio = await _apiBaseHelper.getDio();
      dio.options.headers['Content-Type'] = 'application/json;charset=UTF-8';
      if (token != null) {
        dio.options.headers["Authorization"] = token;
      }
      Response response =
          await dio.get(route, queryParameters: queryParameters);
      return response;
    } on DioError catch (e) {
      return e;
    }
  }

  Future putApi(String route, Map<String, dynamic> body, String token,
      Map<String, dynamic> queryParameters) async {
    try {
      print(body);
      Dio dio = await _apiBaseHelper.getDio();
      dio.options.headers['Content-Type'] = 'application/json;charset=UTF-8';
      if (token != null) {
        dio.options.headers["Authorization"] = token;
      }
      Response response =
          await dio.put(route, data: body, queryParameters: queryParameters);
      return response;
    } on DioError catch (e) {
      return e;
    }
  }

  Future postArchive(String route, FormData formData, String token) async {
    try {
      Dio dio = await _apiBaseHelper.getDio();
      dio.options.headers['Content-Type'] =
          'multipart/form-data; boundary=<calculated when request is sent>';
      if (token != null) {
        dio.options.headers["Authorization"] = token;
      }
      Response response = await dio.post(route, data: formData);
      return response;
    } on DioError catch (e) {
      return e;
    }
  }
}
