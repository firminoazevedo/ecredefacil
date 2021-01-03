import 'package:flutter/material.dart';
import 'package:linhares/models/emprestimo.dart';

class EmprestimoStatus extends StatelessWidget {
  final Emprestimo emprestimo;
  EmprestimoStatus(this.emprestimo);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Status do Emprestimo'),
      ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Tipo: ' + emprestimo.tipo),
          Text('Cashback: ' + emprestimo.valor.toString()),
          Text('Valor: ' + emprestimo.cashbackValue.toString()),
          Text('Status: ' + emprestimo.status),
        ],
    ),
      ),
    );
  }
}