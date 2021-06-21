import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:teste_byebnk/features/transactions/user_transactions_screen.dart';
import 'login_controller.dart';
import 'package:teste_byebnk/model/LoadingState.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = GetIt.I.get<LoginController>();
  Widget build(BuildContext context) {
    return Scaffold(body: Observer(
      builder: (context) {
        switch (controller.loadingState) {
          case LoadingState.LOADING:
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          default:
            return Container(
              padding: EdgeInsets.all(50),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: "E-mail"),
                    onChanged: controller.userLogin.setUser,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: "Senha"),
                    onChanged: controller.userLogin.setPassword,
                  ),
                  Observer(
                    builder: (context) {
                      return ElevatedButton(
                          onPressed: controller.canProceedToLogin
                              ? () {
                                  controller.postLogin().then((value) {
                                    if (value.result) {
                                      navigateToTransactions();
                                    } else {
                                      showErrorDialog(value.message);
                                    }
                                  });
                                }
                              : null,
                          child: Text("LOGIN"));
                    },
                  )
                ],
              ),
            );
        }
      },
    ));
  }

  showErrorDialog(String text) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: MediaQuery.of(context).size.width * 0.3,
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 17),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      text,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "OK",
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  navigateToTransactions() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => UserTransactionsScreen()));
  }
}
