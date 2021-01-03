import 'package:flutter/material.dart';
import 'package:linhares/models/amigo.dart';

class AmigoInfoPage extends StatelessWidget {
  final Amigo amigo;
  AmigoInfoPage(this.amigo);
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
          Text(amigo.nome ?? 'null'),
          Text(amigo.valorPorIndicacao ?? 'null'),
          Text(amigo.status ?? 'null'),
        ],
    ),
      ),
    );
  }
}