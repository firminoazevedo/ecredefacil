import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:linhares/animation/FadeAnimation.dart';
import 'package:linhares/components/button.dart';
import 'package:linhares/providers/auth.dart';
import 'package:linhares/utils/url.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String _url = '${ApiURL.url}usuarios/';
  bool _isLoading = false;
  Map mapUser = {};

  Future<void> carregarPerfil () async {
    Auth auth = Provider.of<Auth>(context, listen: false);
    final resposta = await http.get(_url + auth.getUserId,);
    mapUser = jsonDecode(resposta.body)['resultado'][0];
    print(mapUser);
    
  }

  @override
  void initState() {
    super.initState();
    carregarPerfil().then((value) => {
      setState(() {
    })
    });
  }

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context, listen: false);
    return _isLoading ? Center(
      child: CircularProgressIndicator()) : Scaffold(
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
                  radius: 60,
                  backgroundImage: NetworkImage(mapUser['urlprofile'] ?? 'https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png'),
                  backgroundColor: Colors.deepOrange,
                  child: Icon(Icons.verified_user),
                ),
                Text(
                  auth.getEmail,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w200,
                      color: Colors.white),
                ),
                Text(
                  'Matenha sempre seus dados atualizados\n Confira seu email',
                  textAlign: TextAlign.center,
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
                                icon: Icon(Icons.person),
                                hintText: mapUser['nome'])),
                        TextField(
                          enabled: false,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                icon: Icon(Icons.phone),
                                hintText: mapUser['telefone'].toString())),
                        TextField(
                          enabled: false,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                icon: Icon(Icons.credit_card),
                                hintText: mapUser['cpf'])),
                        TextField(
                          enabled: false,
                            decoration: InputDecoration(
                                icon: Icon(Icons.add_road_outlined),
                                hintText: mapUser['rua'].toString())),
                        TextField(
                          enabled: false,
                            decoration: InputDecoration(
                                icon: Icon(Icons.location_on),
                                hintText: mapUser['bairro'].toString())),
                        TextField(
                          enabled: false,
                            decoration: InputDecoration(
                                icon: Icon(Icons.location_city),
                                hintText: mapUser['cidade'].toString())),
                        TextField(
                          enabled: false,
                            decoration: InputDecoration(
                                icon: Icon(Icons.location_city),
                                hintText: mapUser['estado'].toString())),
                        TextField(
                          enabled: false,
                            decoration: InputDecoration(
                                icon: Icon(Icons.work),
                                hintText: mapUser['profissao'].toString())),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(mapUser['urlRGFrente'] ?? 'https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png'),
                                  radius: 40,
                                  backgroundColor: Colors.deepOrange,
                                  child: Icon(Icons.verified_user),
                                ),
                                FlatButton.icon(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.add_a_photo,
                                      color: Colors.grey,
                                      size: 15,
                                    ),
                                    label: Text(
                                      'Frente do RG',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 10),
                                    )),
                              ],
                            ),
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(mapUser['urlRGVerso'] ?? 'https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png'),
                                  radius: 40,
                                  backgroundColor: Colors.deepOrange,
                                  child: Icon(Icons.verified_user),
                                ),
                                FlatButton.icon(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.add_a_photo,
                                      color: Colors.grey,
                                      size: 15,
                                    ),
                                    label: Text(
                                      'Verso do RG',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 10),
                                    )),
                              ],
                            ),
                          ],
                        ),
                        
                        ButtonRounded('SALVAR', Colors.deepOrange, () {
                          carregarPerfil();
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
