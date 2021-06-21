import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:teste_byebnk/features/applications/application_screen.dart';
import 'package:teste_byebnk/features/transactions/GetTransactions.dart';

import 'transactions_controller.dart';
import 'package:teste_byebnk/model/LoadingState.dart';

import 'package:teste_byebnk/util/stringUtil.dart';

class UserTransactionsScreen extends StatefulWidget {
  const UserTransactionsScreen({Key key}) : super(key: key);

  @override
  _UserTransactionsScreenState createState() => _UserTransactionsScreenState();
}

class _UserTransactionsScreenState extends State<UserTransactionsScreen> {
  final controller = GetIt.I.get<TransactionsController>();
  @override
  void initState() {
    super.initState();
    controller.getUserTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Transações"),
      ),
      body: Observer(
        builder: (context) {
          switch (controller.loadingState) {
            case LoadingState.LOADING:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case LoadingState.ERROR:
              return RefreshIndicator(
                onRefresh: controller.getUserTransactions,
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Erro ao carregar informações"),
                      ],
                    ),
                  ),
                ),
              );
              break;
            case LoadingState.SUCCESS:
              return RefreshIndicator(
                onRefresh: controller.getUserTransactions,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.height * 0.2,
                      child: TextFormField(
                        enabled: false,
                        textAlign: TextAlign.center,
                        initialValue:
                            StringUtil.convertMoneyString(controller.balance),
                        decoration: InputDecoration(
                            prefixText: "R\$",
                            alignLabelWithHint: true,
                            labelText: "SALDO",
                            floatingLabelBehavior: FloatingLabelBehavior.auto),
                      ),
                    ),
                    Divider(),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: controller.userTransactions.length,
                          itemBuilder: (context, index) =>
                              userTransactionWidget(
                                  controller.userTransactions[index])),
                    )
                  ],
                ),
              );
              break;
            case LoadingState.NONE:
              return Container();
              break;
            case LoadingState.EMPTY:
              return RefreshIndicator(
                onRefresh: controller.getUserTransactions,
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Você ainda não realizou transações"),
                      ],
                    ),
                  ),
                ),
              );

              break;
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ApplicationScreen()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.34,
          child: Row(
            children: [Text("Nova operação"), Icon(Icons.add)],
          ),
        ),
      ),
    );
  }

  Widget userTransactionWidget(GetTransactions transaction) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 5,
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(transaction.tipo.toUpperCase()),
                Text(
                  StringUtil.convertMoneyString(transaction.valor),
                  style: TextStyle(
                      color: transaction.tipo == "aplicacao"
                          ? Colors.green
                          : Colors.red),
                )
              ],
            ),
            Divider(),
            Container(
                margin: EdgeInsets.only(top: 5),
                alignment: Alignment.centerLeft,
                child: Text(
                  StringUtil.convertDate(transaction.data),
                ))
          ],
        ),
      ),
    );
  }
}
