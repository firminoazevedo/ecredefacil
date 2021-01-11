import 'package:flutter/material.dart';
import 'package:linhares/models/emprestimo.dart';
import 'package:linhares/providers/emprestimos.dart';
import 'package:linhares/screens/info/emprestimoStatus.dart';
import 'package:provider/provider.dart';

class EmprestimosPage extends StatefulWidget {
  @override
  _EmprestimosPageState createState() => _EmprestimosPageState();
}

class _EmprestimosPageState extends State<EmprestimosPage> {
  bool _isLoading = true;
  List<Emprestimo> emprestimos = [];

  Future<void> _refreshIndicator(BuildContext context) {
    return Provider.of<Emprestimos>(context, listen: false).loadEmprestimos();
  }

  // Carregar amigos ao iniciar a tela
  @override
  void initState() {
    super.initState();
    Provider.of<Emprestimos>(context, listen: false)
        .loadEmprestimos()
        .then(((_) {
      setState(() {
        _isLoading = false;
      });
    }));
    emprestimos =
        Provider.of<Emprestimos>(context, listen: false).getEmprestimos;
  }

  @override
  Widget build(BuildContext context) {
    print(emprestimos.length.toString());
    emprestimos =
        Provider.of<Emprestimos>(context, listen: true).getEmprestimos;
    return Column(
      children: [
        Text('Lista de emprestimos solicitados', style: TextStyle(
          color: Colors.white,
        ),),
        SizedBox(height: 8,),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => _refreshIndicator(context),
            child: _isLoading == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : emprestimos.length < 1
                    ? Center(
                        child: Text('Você ainda não tem \nempréstimos cadastrados'),
                      )
                    : ListView.builder(
                        itemCount: emprestimos.length,
                        itemBuilder: (BuildContext context, int i) {
                          return Column(
                            children: <Widget>[
                              ListTile(
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          EmprestimoStatus(emprestimos[i]),
                                    ));
                                  },
                                ),
                                leading: emprestimos[i].status == 'Aprovado'
                                    ? CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Icon(Icons.check))
                                    : emprestimos[i].status == 'Reprovado'
                                        ? Icon(
                                            Icons.highlight_off,
                                          )
                                        : Icon(Icons.pending),
                                title: Text(
                                  emprestimos[i].tipo,
                                  style: TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  'Valor: ' + emprestimos[i].valor.toString(),
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
          ),
        ),
      ],
    );
  }
}
