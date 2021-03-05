import 'dart:convert';

import 'package:http/http.dart' as http;

class UserRepository {
  final String _loginUrl = 'http://localhost:3000/user/usuarios/login';

  Future<Map<String, dynamic>> login (String email, String password) async {
    final resposta = await http.post(_loginUrl,
    headers: {
      "Content-Type": "application/json"
    },
        body: json.encode({
          "email": email,
          "senha": password,
        }));
    final responseBody = json.decode(resposta.body);
    return responseBody;
  }
}