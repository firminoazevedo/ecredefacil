import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:linhares/models/emprestimo.dart';

class Emprestimos with ChangeNotifier {
  final String _url = 'http://localhost:3000/';
  List<Emprestimo> _emprestimos = [];
  List<Emprestimo> get getEmprestimos => [..._emprestimos];
  String _token;
  // ignore: unused_field
  String _userId;

  Emprestimos(this._token, this._userId, this._emprestimos);

  // ADICIONA UM EMPRESTIMO
  Future<void> addEmprestimo(Emprestimo emprestimo) {
    print(_url + 'emprestimos');
    http
        .post(_url + 'emprestimos',
            headers: {"Authorization": "Bearer $_token", "Content-Type": "application/json"},
            body: json.encode({
              "id_usuario": _userId,
              "valor_emprestimo": emprestimo.valor,
              "cashback": emprestimo.cashbackValue,
              "status": emprestimo.status,
            }))
        .then((response) {
          print(response.body);
      _emprestimos.add(emprestimo);
      notifyListeners();
    });
    return Future.value();
  }

  // CARREGAR TODOS EMPRESTIMOS PARA A CLASSE ATUAL
  Future<void> loadEmprestimos() async {
    _emprestimos.clear();
    print(_userId);
    print(_token);
    final response = await http.get(_url + 'emprestimos/usuario/' + _userId,
        headers: {"Authorization": "Bearer $_token"});
    Map<String, dynamic> emprestimosUsuario = json.decode(response.body);
    List emprestimos = emprestimosUsuario['resultado'];
    emprestimos.forEach((emprestimo) => (_emprestimos.add(
          Emprestimo(
              tipo: 'Margem innss',
              valor: double.parse(emprestimo['valor_emprestimo'].toString()),
              cashbackValue: double.parse(emprestimo['cashback'].toString()),
              status: emprestimo['status']),
        )));

    notifyListeners();
  }

  // DELETA UM EMPRESTIMO
  void remover() {
    _emprestimos.removeLast();
    notifyListeners();
  }
}
