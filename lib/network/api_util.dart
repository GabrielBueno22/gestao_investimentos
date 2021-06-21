import 'package:dio/dio.dart';

class ApiUtil {
  static String showNETWORKErrorMessage(DioError messages) {
    switch (messages.type) {
      case DioErrorType.connectTimeout:
        return "O tempo de solicitação da conexão expirou. Tente novamente mais tarde";
        break;
      case DioErrorType.sendTimeout:
        return "O tempo de envio da solicitação expirou. Tente novamente mais tarde";
        break;
      case DioErrorType.receiveTimeout:
        return "O tempo de recebimento da solicitação expirou. Tente novamente mais tarde";
        break;
      case DioErrorType.other:
        return "Ocorreu um erro ao salvar os dados.\nVerifique sua conexão e tente novamente mais tarde";
        break;
      case DioErrorType.response:
        return messages.response.data["errors"];
        break;
      case DioErrorType.cancel:
        return "A solicitação foi cancelada. Tente novamente mais tarde";
        break;
      default:
        return "Algo inesperado ocorreu. Tente novamente mais tarde";
        break;
    }
  }

  static String showAPIErrorMessage(Map<String, dynamic> messages) {
    if (messages["status"]["code"] >= 500) {
      return "Infelizmente alguma coisa deu errado. Por favor, volte e tente novamente.";
    } else {
      if (messages["message"] != null) {
        return messages["message"];
      } else {
        return messages["message"].first;
      }
    }
  }
}
