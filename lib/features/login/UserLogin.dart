import 'package:mobx/mobx.dart';
part 'UserLogin.g.dart';

class UserLogin = _UserLoginBase with _$UserLogin;

abstract class _UserLoginBase with Store {
  @observable
  String username;
  @action
  setUser(String value) => username = value;

  @observable
  String password;
  @action
  setPassword(String value) => password = value;

  UserLogin fromJson(Map<String, dynamic> json) => UserLogin()
    ..setUser(json["user"])
    ..setPassword(json["pwd"]);

  Map<String, dynamic> toJson() => {
        "username": username == null ? null : username,
        "password": password == null ? null : password,
      };
}
