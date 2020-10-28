import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileStatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Parabés\nVocê se cadastrou com sucesso!\n O seu Cadastro está em análise!\nVolte mais tarde para conferir o resultado',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
