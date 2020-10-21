import 'package:flutter/material.dart';
import 'package:linhares/components/button.dart';

import 'home.dart';

class CongratulationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Parabéns'),
            Text('Seu empréstimo foi solicitado'),
            Text('Aguarde a aprovação'),
            Spacer(),
            ButtonRounded('Voltar', Colors.black, () {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
            })
          ],
        ),
      ),
    );
  }
}
