import 'package:flutter/material.dart';
import 'package:linhares/models/amigo.dart';
import 'package:linhares/providers/amigos.dart';
import 'package:linhares/screens/info/amigoInfo.dart';
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
    return Column(
      children: [
        Text('Lista de Amigos indicados'),
        Expanded(
          child: Container(
            child: RefreshIndicator(
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
                                    amigos[i].status ?? 'null',
                                    style: TextStyle(color: Colors.grey[400]),
                                  ),
                                  trailing: IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    AmigoInfoPage(amigos[i]),
                              ));
                            },
                          ),
                                ),
                                Divider(
                                  height: 2.0,
                                ),
                              ],
                            );
                          },
                        ),
            ),
          ),
        ),
      ],
    );
  }
}
