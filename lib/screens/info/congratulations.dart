import 'package:flutter/material.dart';
import 'package:linhares/components/button.dart';

import '../home.dart';

class CongratulationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment(0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Parabéns',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 36
            ),),
            Text('Seu empréstimo foi solicitado'),
            Text('Aguarde a aprovação'),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: ButtonRounded('Voltar', Colors.black, () {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
            }),
              ),
            )
            
            
          ],
        ),
      ),
    );
  }
}
