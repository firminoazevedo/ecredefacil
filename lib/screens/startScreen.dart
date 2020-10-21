import 'package:flutter/material.dart';
import 'package:linhares/animation/FadeAnimation.dart';
import 'package:linhares/screens/login.dart';
import 'package:linhares/screens/singUp.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg_startpage.jpg',), fit: BoxFit.cover)
        ),
        child: Padding(
          padding: const EdgeInsets.all(38.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              SizedBox(height: 150,),
              FadeAnimation(1.4, Text('Olá, \nSeja bem vindo ao \nÉ crédito é Fácil!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ),
              Spacer(),

              //Botão entrar
              FadeAnimation(1.8,
                Container(
                  height: 50,
                  width: 110,
                  child: RaisedButton(
                      child: Text(
                        'Entrar',
                        style: TextStyle(color: Colors.orange),
                      ),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginPage()));
                      }),
                ),
              ),

              // Botão Criar acesso
              FadeAnimation(2.1,
                Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 50,
                  width: 130,
                  child: RaisedButton(
                      child: Text(
                        'Criar acesso',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.orange,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SingupPage()));
                      }),
                ),
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}
