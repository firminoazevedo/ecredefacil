
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:linhares/animation/FadeAnimation.dart';
import 'package:linhares/components/button.dart';
import 'package:linhares/providers/auth.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {



    Auth auth = Provider.of<Auth>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          child: Container(
            color: Colors.green[800],
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 25,
                ),

                CircleAvatar(
                  backgroundColor: Colors.deepOrange,
                   child: Icon(Icons.verified_user),
                ),
                
                Text(
                  'auth.email',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w200,
                      color: Colors.white),
                ),
                Text(
                  'O seu cadastro irá para análise!\n digite os dados corretamente',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w200,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                FadeAnimation(
                  1.4,
                  Container(
                    padding: EdgeInsets.all(32),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          enabled: false,
                            decoration: InputDecoration(
                                icon: Icon(Icons.person), hintText: 'Nome Completo')),
                        TextField(
                          keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                icon: Icon(Icons.phone), hintText: 'Telefone')),
                        TextField(
                          keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                icon: Icon(Icons.credit_card), hintText: 'CPF')),
                        TextField(
                          keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                icon: Icon(Icons.credit_card), hintText: 'RG')),
                        TextField(
                          keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                icon: Icon(Icons.phone), hintText: 'CPF')),
                        TextField(
                            decoration: InputDecoration(
                                icon: Icon(Icons.add_road_outlined), hintText: 'Rua')),
                        TextField(
                            decoration: InputDecoration(
                                icon: Icon(Icons.location_on), hintText: 'Bairro')),
                        TextField(
                            decoration: InputDecoration(
                                icon: Icon(Icons.location_city), hintText: 'Cidade')),
                        TextField(
                            decoration: InputDecoration(
                                icon: Icon(Icons.location_city), hintText: 'Estado')),
                        TextField(
                            decoration: InputDecoration(
                                icon: Icon(Icons.work), hintText: 'Profissão')),
                        
                        SizedBox(height: 20,),
                        ButtonRounded('SALVAR', Colors.deepOrange, () {
                          Firestore.instance.collection('users').add({
                            'nome': 'Firmino azevedo',
                            'sobrenome': 'neto',
                            'profissao': 'Empreendedor'
                          });
                        }),
                        Container(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
