import 'dart:convert';

List<GetTransactions> getTransactionsFromJson(String str) =>
    List<GetTransactions>.from(
        json.decode(str).map((x) => GetTransactions.fromJson(x)));

String getTransactionsToJson(List<GetTransactions> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetTransactions {
  GetTransactions({
    this.tipo,
    this.data,
    this.valor,
  });

  String tipo;
  DateTime data;
  double valor;

  factory GetTransactions.fromJson(Map<String, dynamic> json) =>
      GetTransactions(
        tipo: json["tipo"] == null ? null : json["tipo"],
        data: json["data"] == null ? null : DateTime.parse(json["data"]),
        valor: json["valor"] == null ? null : json["valor"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "tipo": tipo == null ? null : tipo,
        "data": data == null
            ? null
            : "${data.year.toString().padLeft(4, '0')}-${data.month.toString().padLeft(2, '0')}-${data.day.toString().padLeft(2, '0')}",
        "valor": valor == null ? null : valor,
      };
}
