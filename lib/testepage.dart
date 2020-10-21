import 'package:flutter/material.dart';
import 'package:linhares/filter.dart';
import 'package:linhares/models/amigo.dart';
import 'package:linhares/providers/amigos.dart';
import 'package:provider/provider.dart';

class TestePage extends StatefulWidget {
  @override
  _TestePageState createState() => _TestePageState();
}

class _TestePageState extends State<TestePage> {
  @override
  Widget build(BuildContext context) {
    Amigos ami = Provider.of<Amigos>(context, listen: true);
    List<Amigo> amigos = Provider.of<Amigos>(context, listen: true).getAmigos;
    TextEditingController _testControler = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.brightness_1),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FilterPage()));
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
                  itemCount: amigos.length,
                  itemBuilder: (ctx, i) => ListTile(
                        title: Text(amigos[i].nome),
                        subtitle: Text(amigos[i].valorPorIndicacao),
                      ))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlatButton(
                  onPressed: () {
                    ami.addAmigo(
                        Amigo(nome: _testControler.text, valorPorIndicacao: '300'));
                    _testControler.text = '';
                  },
                  child: Text('Adicionar')),
              FlatButton(
                  onPressed: () {
                    ami.remover();
                  },
                  child: Text('Remover')),
            ],
          )
        ],
      ),
    );
  }
}
