import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linhares/models/emprestimo.dart';
import 'package:linhares/providers/auth.dart';
import 'package:provider/provider.dart';

import 'info/emprestimoStatus.dart';

class EmprestimosFirebasePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context, listen: false);
    return StreamBuilder(
      stream: Firestore.instance
          .collection('users')
          .document(auth.getUid)
          .collection('emprestimos')
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());

        final emprestimos = snapshot.data.documents;
        print(emprestimos);

        return ListView.builder(
          itemCount: emprestimos.length,
          itemBuilder: (ctx, i) => Column(
            children: [
              ListTile(
                trailing: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EmprestimoStatus(
                        Emprestimo(tipo: emprestimos[i]['tipo'], valor: emprestimos[i]['valor'], cashbackValue: emprestimos[i]['cashbackvalue'])
                      ),
                    ));
                  },
                ),
                leading: emprestimos[i]['status'] == 'Aprovado'
                    ? CircleAvatar(
                        backgroundColor: Colors.white, child: Icon(Icons.check))
                    : emprestimos[i]['status'] == 'Reprovado'
                        ? Icon(
                            Icons.highlight_off,
                          )
                        : Icon(Icons.pending),
                title: Text(
                  emprestimos[i]['valor'].toString(),
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  'Categoria: ' + emprestimos[i]['tipo'],
                  style: TextStyle(color: Colors.grey[400]),
                ),
              ),
              Divider(
                height: 2.0,
              ),
            ],
          ),
        );
      },
    );
  }
}
