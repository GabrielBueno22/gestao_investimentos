import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_configurations.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiHelper {
  //Configurações do Helper para utilização do package dio para respostas da api

  static const platform = const MethodChannel('flutter.native/helper');

  Dio _dio;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  // Singleton
  ApiHelper._privateConstructor();
  static final ApiHelper instance = ApiHelper._privateConstructor();

  Future<Dio> getDio() async {
    _dio = new Dio();
    _dio.options.baseUrl = ApiConfigurations.getApi();
    String proxy = await getProxy();
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.findProxy = (uri) {
        return (proxy != null && proxy != "") ? "PROXY $proxy" : 'DIRECT';
      };

      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      _dio.options.headers = {
        "Device": "${androidInfo.manufacturer} ${androidInfo.model}"
      };
      _dio.options.headers = {
        "Os":
            "${androidInfo.version.baseOS} ${androidInfo.version.release} ${androidInfo.version.sdkInt}"
      };
      _dio.options.headers = {"Uuid": androidInfo.androidId};
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      _dio.options.headers = {"Device": iosInfo.utsname.machine};
      _dio.options.headers = {
        "Os": "${iosInfo.systemName} ${iosInfo.systemVersion}"
      };
      _dio.options.headers = {"Uuid": iosInfo.identifierForVendor};
    }
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _dio.options.headers = {"Version": packageInfo.buildNumber};

    _dio.interceptors.add(PrettyDioLogger());
    return _dio;
  }

  Future<String> getProxy() async {
    String response = "";
    try {
      final String result = await platform.invokeMethod('getProxy');
      print(result);
      response = result;
    } catch (e) {
      print(e);
      response = "";
    }
    return response;
  }
}
