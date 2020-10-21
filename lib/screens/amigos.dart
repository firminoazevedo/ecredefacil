import 'package:flutter/material.dart';
import 'package:linhares/models/amigo.dart';
import 'package:linhares/providers/amigos.dart';
import 'package:provider/provider.dart';

class AmigosPage extends StatefulWidget {
  @override
  _AmigosPageState createState() => _AmigosPageState();
}

class _AmigosPageState extends State<AmigosPage> {
  bool _isLoading = true;
  List<Amigo> amigos = [];

  Future<void> _refreshIndicator(BuildContext context) {
    return Provider.of<Amigos>(context, listen: false).loadAmigos();
  }

  @override
  void initState() {
    super.initState();
    Provider.of<Amigos>(context, listen: false).loadAmigos().then(((_) {
      setState(() {
        _isLoading = false;
      });
    }));
    amigos = Provider.of<Amigos>(context, listen: false).getAmigos;
    print(amigos);
  }

  @override
  Widget build(BuildContext context) {
    print(amigos.length.toString());
    amigos = Provider.of<Amigos>(context, listen: true).getAmigos;
    return RefreshIndicator(
      onRefresh: () => _refreshIndicator(context),
      child: _isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : amigos.length < 1
              ? Center(
                  child: Text('Você ainda não tem \namigos indicados'),
                )
              : ListView.builder(
                  itemCount: amigos.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          leading: amigos[i].status == 'Aprovado'
                              ? CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.check))
                              : amigos[i].status == 'Reprovado'
                                  ? Icon(
                                      Icons.highlight_off,
                                    )
                                  : Icon(Icons.pending),
                          title: Text(
                            amigos[i].nome,
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            amigos[i].valorPorIndicacao.toString(),
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                        ),
                        Divider(
                          height: 2.0,
                        ),
                      ],
                    );
                  },
                ),
    );
  }
}
