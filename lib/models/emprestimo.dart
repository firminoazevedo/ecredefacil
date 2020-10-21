import 'package:flutter/foundation.dart';

class Emprestimo {
  String tipo;
  double valor;
  double cashbackValue;
  String status;

  Emprestimo({
    @required this.tipo,
    @required this.valor,
    @required this.cashbackValue,
    this.status = 'Em análise',
  });
}