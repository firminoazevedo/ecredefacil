import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:linhares/exceptions/firabese_exceptions.dart';

class Auth with ChangeNotifier {
  String _idUsuario;
  String _email;
  String _token;
  // ignore: unused_field
  DateTime _expiryDate;
  String _uid;

  String get getUid {
    return _uid;
  }

  void setUid(String uid) {
    this._uid = uid;
  }

  bool get isAuth {
    return token != null;
  }

  void addUser(Map user) {
    _email = user['email'];
  }

  void setEmail(String email) {
    _email = email;
  }

  // retornar email para o usuario
  String get getEmail {
    return _email;
  }

  String get getUserId {
    return _idUsuario;
  }

  String get token {
    return _token;
  }


  Future<void> _authenticate(
      String email, String password, String segment) async {
    final _url = "http://localhost:3000/usuarios/login";

    final response = await http.post(_url,
    headers: {
      "Content-Type": "application/json"
    },
        body: json.encode({
          "email": email,
          "senha": password,
        }));
    final responseBody = json.decode(response.body);
    print(responseBody);


    if (responseBody["error"] != null) {
      throw AuthExceptionHttp(responseBody['error']['message']);
    } else {
      _token = responseBody["token"];
      _idUsuario = responseBody["id_usuario"].toString();
      /*_expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseBody["expiresIn"])));
      print(responseBody);*/

      print(_idUsuario + 'jdjdjdj');
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> singup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> carregarDadosUsuario() async {
    final String _url = 'http://localhost:3000/';
    final response = await http.get(_url + 'usuarios/' + _idUsuario,
        headers: {"Authorization": "Bearer $_token"});
        print(_url + '/usuarios/' + _idUsuario);
    List usuario = json.decode(response.body)['resultado'];
    print(json.decode(response.body));
    notifyListeners();
  }
}
