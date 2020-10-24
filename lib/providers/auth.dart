import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:linhares/exceptions/firabese_exceptions.dart';

class Auth with ChangeNotifier {
  String _userId;
  String _email;
  String _token;
  DateTime _expiryDate;

  bool get isAuth {
    return token != null;
  }

  void addUser(Map user){
    _email = user['email'];
  }

  // retornar email para o usuario
  String get email{
    return _email;
  }

  String get getUserId {
    return isAuth ? _userId : null;
  }

  String get token {
    if (_token != null &&
        _expiryDate != null &&
        _expiryDate.isAfter(DateTime.now())) {
      return _token;
    } else {
      return null;
    }
  }

  Future<void> _authenticate(
      String email, String password, String segment) async {
    final _url =
        "https://identitytoolkit.googleapis.com/v1/accounts:$segment?key=AIzaSyBeTwW5HYc2m63DMo1-7iov1KzMJKS_TNs";

    final response = await http.post(_url,
        body: json.encode({
          "email": email,
          "password": password,
          "returnSecureToken": true,
        }));
    final responseBody = json.decode(response.body);
    if (responseBody["error"] != null) {
      throw AuthExceptionHttp(responseBody['error']['message']);
    } else {
      _token = responseBody["idToken"];
      _userId = responseBody["localId"];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseBody["expiresIn"])));
      print(responseBody);
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
}
