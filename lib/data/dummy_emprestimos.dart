import 'package:linhares/data/dummy_data.dart';
import 'package:linhares/models/categoria.dart';
import 'package:linhares/models/emprestimo.dart';


List<Categoria> categorias = DUMMY_CATEGORIA;

// ignore: non_constant_identifier_names
final DUMMY_EMPRESTIMOS = [
  Emprestimo(tipo: categorias[0].nome, valor: 1000, cashbackValue: categorias[0].cashback / 100 * 1000),
  Emprestimo(tipo: categorias[1].nome, valor: 2000, cashbackValue: categorias[0].cashback / 100 * 2000),
  Emprestimo(tipo: categorias[0].nome, valor: 3000, cashbackValue: categorias[0].cashback / 100 * 3000),
  Emprestimo(tipo: categorias[1].nome, valor: 4000, cashbackValue: categorias[0].cashback / 100 * 4000),
  Emprestimo(tipo: categorias[0].nome, valor: 5000, cashbackValue: categorias[0].cashback / 100 * 5000),
  Emprestimo(tipo: categorias[0].nome, valor: 5000, cashbackValue: categorias[0].cashback / 100 * 5000,),
];