

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linhares/providers/auth.dart';
import 'package:provider/provider.dart';

class AmigosFirebasePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context, listen: false);
    final uid = auth.getUid;
    return StreamBuilder(
      stream: Firestore.instance.collection('users').document('OC8kUDK6ohRFYnDvlQNGFcGLBoj1').collection('emprestimos').snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
        return Center(child: CircularProgressIndicator());

        final emprestimos = snapshot.data.documents;
        print(emprestimos);

        return ListView.builder(
          itemCount: emprestimos.length,
          itemBuilder: (ctx, i) => ListTile(
            title: Text(emprestimos[i]['nome']),
          ),
        );
      },
    );
  }
}