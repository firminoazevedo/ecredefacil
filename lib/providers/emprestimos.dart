import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:linhares/models/emprestimo.dart';

class Emprestimos with ChangeNotifier {
  final String _url = 'https://linhares-d11b1.firebaseio.com/emprestimos/';
  List<Emprestimo> _emprestimos = [];
  List<Emprestimo> get getEmprestimos => [..._emprestimos];
  String _token;
  String _userId;

  Emprestimos(this._token, this._userId, this._emprestimos);
  

  Future<void> addEmprestimo(Emprestimo emprestimo) {
    http
        .post(_url+ '$_userId'+ '.json?auth=''$_token',
            body: json.encode({
              "tipo": emprestimo.tipo,
              "valor": emprestimo.valor,
              "cashback": emprestimo.cashbackValue,
              "status": emprestimo.status,
            }))
        .then((response) {
      _emprestimos.add(emprestimo);
      notifyListeners();
    });
    return Future.value();
  }

  Future<void> loadEmprestimos() async {
    _emprestimos.clear();
    final response = await http.get(_url+'$_userId'+'.json?auth=''$_token');
    Map<String, dynamic> emprestimosUsuario = json.decode(response.body);
    emprestimosUsuario.forEach((emprestimoId, emprestimo) {
      print(emprestimo);
      _emprestimos.add(
        Emprestimo(
            tipo: emprestimo['tipo'],
            valor: emprestimo['valor'],
            cashbackValue: emprestimo['cashback'],
            status: emprestimo['status']),
      );
    });
    notifyListeners();
  }

  void remover() {
    _emprestimos.removeLast();
    notifyListeners();
  }
}
