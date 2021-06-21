import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:teste_byebnk/model/LoadingState.dart';

import 'applications_controller.dart';

class ApplicationScreen extends StatefulWidget {
  const ApplicationScreen({Key key}) : super(key: key);

  @override
  _ApplicationScreenState createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  final controller = GetIt.I.get<ApplicationsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aplicar/Resgatar"),
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          child: Observer(builder: (_) {
            switch (controller.loadingState) {
              case LoadingState.LOADING:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              default:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      onChanged: controller.setApplicationValue,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        RealInputFormatter(centavos: true)
                      ],
                      decoration: InputDecoration(
                          prefixText: "R\$ ",
                          labelText: "Valor",
                          hintText: "Valor"),
                    ),
                    ButtonBar(
                      children: [
                        Observer(builder: (context) {
                          return ElevatedButton(
                              onPressed: controller.canPostApplication
                                  ? () {
                                      controller
                                          .putUserTransactions(0)
                                          .then((value) {
                                        if (value.result) {
                                          showSuccess(value.message);
                                        } else {
                                          showError(value.message);
                                        }
                                      });
                                    }
                                  : null,
                              child: Text("Aplicação"));
                        }),
                        Observer(builder: (context) {
                          return ElevatedButton(
                              onPressed: controller.canPostApplication
                                  ? () {
                                      controller
                                          .putUserTransactions(1)
                                          .then((value) {
                                        if (value.result) {
                                          showSuccess(value.message);
                                        } else {
                                          showError(value.message);
                                        }
                                      });
                                    }
                                  : null,
                              child: Text("Resgate"));
                        })
                      ],
                    )
                  ],
                );
            }
          })),
    );
  }

  showSuccess(String text) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              CupertinoIcons.check_mark_circled,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                text,
                maxLines: 2,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        action: SnackBarAction(
          textColor: Colors.white,
          label: "OK",
          onPressed: () {},
        )));
  }

  showError(String text) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.error_outline_outlined,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                text,
                maxLines: 2,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        action: SnackBarAction(
          textColor: Colors.white,
          label: "OK",
          onPressed: () {},
        )));
  }
}
