import 'package:flutter/material.dart';
import 'package:linhares/providers/emprestimos.dart';
import 'package:provider/provider.dart';

import 'models/emprestimo.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  Widget build(BuildContext context) {
    List<Emprestimo> emprestimos = Provider.of<Emprestimos>(context, listen: true).getEmprestimos;
    List<Emprestimo> emp = emprestimos.where((e) => e.status == 'Em análise' && e.tipo == 'Firmino').toList();
    return Scaffold(
      appBar: AppBar(title: Text('data'),),
      body: ListView.builder(
        itemCount: emp.length,
        itemBuilder: (ctx, i) => ListTile(
          title: Text(emp[i].tipo),
        )
        )
    );
  }
}