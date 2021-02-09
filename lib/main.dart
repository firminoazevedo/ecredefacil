import 'package:flutter/material.dart';
import 'package:linhares/providers/amigos.dart';
import 'package:linhares/providers/auth.dart';
import 'package:linhares/providers/emprestimos.dart';
import 'package:linhares/screens/startScreen.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new Auth()),
        ChangeNotifierProxyProvider<Auth, Emprestimos>(
          create: (_) => Emprestimos(
            null,
            null,
            [],
          ),
          update: (ctx, auth, previousEmprestimo) => new Emprestimos(
              auth.token, auth.getUserId, previousEmprestimo.getEmprestimos),
        ),
        ChangeNotifierProxyProvider<Auth, Amigos>(
          create: (_) => Amigos(null, null, []),
          update: (ctx, auth, previousAmigos) =>
              new Amigos(auth.token, auth.getUserId, previousAmigos.getAmigos),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Linhares',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StartPage(),
      ),
    );
  }
}
