import 'package:flutter/material.dart';

class CategorieCard extends StatelessWidget {
  final String categoria;
  final double juros;

  CategorieCard({
    this.categoria,
    this.juros,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Center(
        child: Column(children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    categoria.toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.w900, color: Colors.grey),
                  ),
                  Text('Juros a partir de $juros%'),
                  Spacer(),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(40)),
              ),
              child: FlatButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [Text('Solicitar'), Icon(Icons.arrow_forward_ios)],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
