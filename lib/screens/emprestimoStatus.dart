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
          Text(emprestimo.tipo),
          Text(emprestimo.valor.toString()),
          Text(emprestimo.cashbackValue.toString()),
          Text(emprestimo.status),
        ],
    ),
      ),
    );
  }
}