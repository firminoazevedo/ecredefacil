import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linhares/components/button.dart';
import 'package:linhares/data/dummy_data.dart';
import 'package:linhares/models/categoria.dart';
import 'package:linhares/screens/efetuar_emprestimo_page.dart';

class GridDashboard extends StatelessWidget {
  final TextEditingController _valorDesejado;
  GridDashboard(this._valorDesejado);

  @override
  Widget build(BuildContext context) {
    List<Categoria> myList = DUMMY_CATEGORIA;

    void _showDialogMensage() {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('Atenção!'),
                content: Text('Digite um valor desejado maior que 100'),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Fechar')),
                ],
              ));
    }

    bool _checkValorDesejado(String valor) {
      if (valor == ''){
        _showDialogMensage();
        return false;
      }

      if (double.parse(valor) < 100 ){
        _showDialogMensage();
        return false;
      }

      return true;
    }

    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.green[600],
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    data.nome,
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Juros a partir de ${data.juros}%',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.white38,
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    'Cashback de ${data.cashback}%',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                            fontWeight: FontWeight.w600)),
                  ),
                  ButtonRounded('Solicitar', Colors.deepOrange[500], () {
                    if (_checkValorDesejado(_valorDesejado.text)) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              EfetuarPage(data, double.parse(_valorDesejado.text))));
                    }
                  })
                ],
              ),
            );
          }).toList()),
    );
  }
}
