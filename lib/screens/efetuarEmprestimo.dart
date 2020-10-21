import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linhares/components/button.dart';
import 'package:linhares/models/categoria.dart';
import 'package:linhares/models/emprestimo.dart';
import 'package:linhares/providers/emprestimos.dart';
import 'package:linhares/screens/congratulations.dart';
import 'package:provider/provider.dart';

class EfetuarPage extends StatefulWidget {
  final Categoria _categoria;
  final double _valordesejado;
  EfetuarPage(this._categoria, this._valordesejado);

  @override
  _EfetuarPageState createState() =>
      _EfetuarPageState(_categoria, _valordesejado);
}

class _EfetuarPageState extends State<EfetuarPage> {
  bool _isLoading = false;
  Categoria _categoria;
  double _valordesejado;
  _EfetuarPageState(this._categoria, this._valordesejado);

  @override
  Widget build(BuildContext context) {

    // Alert dialog
    void _showConfirmationDialog() {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('Você está solicitando um empréstimo'),
                content: Text('Deseja prosseguir?'),
                actions: [
                  FlatButton(
                      onPressed: () async {
                        Emprestimos emprestimos =
                            Provider.of<Emprestimos>(context, listen: false);
                        setState(() {
                          _isLoading = true;
                        });
                        await emprestimos
                            .addEmprestimo(Emprestimo(
                                tipo: _categoria.nome,
                                valor: _valordesejado,
                                cashbackValue:
                                    (3000 * _categoria.cashback) / 100))
                            .then((value) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => CongratulationsPage()));
                        });
                      },
                      child: Text('Sim')),
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Não')),
                ],
              ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_categoria.nome.toUpperCase()),
        elevation: 0,
        backgroundColor: Colors.green[800],
      ),
      body: _isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.green[800],
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(80))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Você está solicitando\num empréstimo de ',
                              style: TextStyle(
                                fontSize: 19,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              )),
                          SizedBox(
                            height: 22,
                          ),
                          Text(
                            'R\$ $_valordesejado ',
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                          SizedBox(
                            height: 22,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'com juros de ${_categoria.juros}%\n e cashback de ',
                    style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'R\$ ${(_valordesejado * _categoria.cashback) / 100}',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 35,
                            fontWeight: FontWeight.w600)),
                  ),
                  Spacer(),
                  ButtonRounded('Solicitar', Colors.black, () {
                    _showConfirmationDialog();
                  }),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
    );
  }
}
