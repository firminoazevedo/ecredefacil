import 'package:flutter/cupertino.dart';

class Amigo {
String nome;
String id;
String valorPorIndicacao;
String status;

Amigo({
  @required this.nome,
  @required this.valorPorIndicacao,
  this.id,
  this.status = 'Em análise'
});

}