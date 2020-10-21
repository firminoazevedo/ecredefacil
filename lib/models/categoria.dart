import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Categoria {
  Icon icon;
  String nome;
  double juros;
  double cashback;

  Categoria ({
    @required this.nome,
    @required this.juros,
    @required this.cashback,
    this.icon
  });
}