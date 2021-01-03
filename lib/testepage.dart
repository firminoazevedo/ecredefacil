import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:linhares/filter.dart';
import 'package:linhares/models/amigo.dart';
import 'package:linhares/providers/amigos.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class TestePage extends StatefulWidget {
  @override
  _TestePageState createState() => _TestePageState();
}

class _TestePageState extends State<TestePage> {

  Map emprestimos;

  void getEmprestimos( ) async {
    final response = await http.get('http://localhost:3000/emprestimos');
    setState(() {
      emprestimos = jsonDecode(response.body);
    });
    
  }

  @override
  void initState() {
    super.initState();
    getEmprestimos();
  }


  @override
  Widget build(BuildContext context) {
    Amigos ami = Provider.of<Amigos>(context, listen: true);
    // ignore: unused_local_variable
    List<Amigo> amigos = Provider.of<Amigos>(context, listen: true).getAmigos;
    TextEditingController _testControler = TextEditingController();

    //final Future<FirebaseApp> _init = Firebase.initializeApp();
    return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    icon: Icon(Icons.brightness_1),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FilterPage()));
                    })
              ],
              title: Text('Pagina de teste'),
            ),
            body: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Center(
                      child: TextFormField(
                        controller: _testControler,
                        decoration: InputDecoration(hintText: 'Digite aqui'),
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: ListView.builder(
                        itemCount: emprestimos['resultado'].length ?? 0,
                        itemBuilder: (ctx, i) => ListTile(
                              title: Text(emprestimos['resultado'][i]['nome'] ?? 'Nenhum Emprestimo'),
                              subtitle: Text(emprestimos['resultado'][i]['cashback'].toString() ?? ''),
                            ))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FlatButton(
                        onPressed: () {
                          ami.addAmigo(Amigo(
                              nome: _testControler.text,
                              valorPorIndicacao: '300'));
                          _testControler.text = '';
                        },
                        child: Text('Adicionar')),
                    FlatButton(
                        onPressed: () {
                          //ami.remover();
                          setState(() {
                            getEmprestimos();
                          });
                          
                        },
                        child: Text('Testar')),
                  ],
                )
              ],
            ));
  }
}
