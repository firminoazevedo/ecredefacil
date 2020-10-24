import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:linhares/models/amigo.dart';

class Amigos with ChangeNotifier {
  String _token;
  // ignore: unused_field
  String _userId;
  Amigos(
    this._token,
    this._userId,
    this._amigos,
  );

  final String _url = 'https://linhares-d11b1.firebaseio.com/amigos.json?auth=';
  List<Amigo> _amigos = [];
  List<Amigo> get getAmigos => [..._amigos];

  Future<void> addAmigo(Amigo amigo) {
    http
        .post(_url + '$_token',
            body: json.encode({
              "nome": amigo.nome,
              "valorporindicacao": amigo.valorPorIndicacao,
              "status": amigo.status,
            }))
        .then((response) {
      _amigos.add(amigo);
      notifyListeners();
    });
    return Future.value();
  }

  Future<void> loadAmigos() async {
    _amigos.clear();
    final response = await http.get(_url + '$_token');
    Map<String, dynamic> amigo = json.decode(response.body);
    amigo.forEach((amigoId, amigo) {
      print(amigo);
      _amigos.add(
        Amigo(
            nome: amigo['nome'],
            valorPorIndicacao: amigo['valorporindicacao'],
            status: amigo['status']),
      );
    });
    notifyListeners();
  }

  // remover amigos
  void remover() {
    _amigos.removeLast();
    notifyListeners();
  }
}
