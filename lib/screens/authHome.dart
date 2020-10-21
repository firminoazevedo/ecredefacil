
import 'package:flutter/material.dart';
import 'package:linhares/providers/auth.dart';
import 'package:linhares/screens/home.dart';
import 'package:linhares/screens/login.dart';
import 'package:provider/provider.dart';

class AuthOrHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
    return auth.isAuth ? Home() : LoginPage();
  }
}