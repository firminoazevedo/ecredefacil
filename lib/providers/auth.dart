import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:linhares/exceptions/firabese_exceptions.dart';
import 'package:linhares/repositories/user_repository.dart';
import 'package:linhares/utils/url.dart';

class Auth with ChangeNotifier {
  String _idUsuario;
  String _email;
  String _token;
  String _uid;
  final UserRepository userRepository = UserRepository();
  
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
  
    String get getEmail {
      return _email;
    }
  
    String get getUserId {
      return _idUsuario;
    }
  
    String get token {
      return _token;
    }
  
  
    Future<void> singup(String email, String password) async {
      return Future.value();
    }
  
    Future<void> login(String email, String password) async {
      final responseBody = await userRepository.login(email, password);
      if (responseBody["mensagem"] == 'Falha ao autenticar'
        || responseBody["mensagem"] == 'Falha na autenticacao'
        || responseBody["error"] != null) {
        throw AuthExceptionHttp(responseBody['mensagem']);
      } else {
        _token = responseBody["token"];
        _idUsuario = responseBody["id_usuario"].toString();
      }
    }
  
    Future<void> carregarDadosUsuario() async {
      final String _url = ApiURL.url;
      final response = await http.get(_url + 'user/usuarios/' + _idUsuario,
          headers: {"Authorization": "Bearer $_token"});
      notifyListeners();
    }
}
