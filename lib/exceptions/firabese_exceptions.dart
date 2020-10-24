class AuthExceptionHttp implements Exception{
  static const Map<String, String> erros = {
    "EMAIL_EXISTS": "O email já existe! tente outro",
    "OPERATION_NOT_ALLOWED": "Operação não permitida",
    "TOO_MANY_ATTEMPTS_TRY_LATER:": " Muitas tentativas, tente mais tarde",
    "INVALID_PASSWORD": "Senha inválida",
    "EMAIL_NOT_FOUND": "Email não encontrado",
    "INVALID_EMAIL": "Email inválido!",
  };

  final String key;

  const AuthExceptionHttp(this.key);

  @override
  String toString() {
    if (erros.containsKey(key))
      return erros[key];
    else
      return "Erro na autenticação";
  }
}