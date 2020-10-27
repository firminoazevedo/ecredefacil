import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:linhares/animation/FadeAnimation.dart';
import 'package:linhares/components/button.dart';
import 'package:linhares/exceptions/firabese_exceptions.dart';
import 'package:linhares/providers/auth.dart';
import 'package:linhares/screens/singUp.dart';
import 'package:linhares/screens/startScreen.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  final TextEditingController _loginMsgController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _loginFirebase () async{
    try {
      setState(() {
        _isLoading = true;
      });
      await _auth.signInWithEmailAndPassword(
      email: _emailController.text, password: _passwordController.text);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    } on PlatformException catch (err){
      _showErrorDialog(err.code);
    } catch (error){
      print(error);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // ignore: unused_element
  void _loginComHttp() async {
    Auth auth = Provider.of(context, listen: false);
    try {
      setState(() {
        _isLoading = true;
      });
      await auth.login(_emailController.text, _passwordController.text);
      auth.addUser({'email': _emailController.text});
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    } on AuthExceptionHttp catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('Ocorreu um erro inesperado');
    }
  }

  

  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Ocorreu um erro'),
              content: Text(msg),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Fechar')),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  width: double.maxFinite,
                  child: Container(
                    color: Colors.green,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 60, right: 60, top: 20),
                          child: Image.asset(
                            "assets/logo.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        Text(
                          'Entrar',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          1.4,
                          Container(
                            padding: EdgeInsets.all(32),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(62),
                                    topRight: Radius.circular(62))),
                            child: Column(
                              children: <Widget>[
                                TextField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                        icon: Icon(Icons.person),
                                        hintText: 'Email')),
                                Padding(
                                  padding: EdgeInsets.only(top: 16, bottom: 32),
                                  child: TextField(
                                    controller: _passwordController,
                                    decoration: InputDecoration(
                                        icon: Icon(Icons.lock),
                                        hintText: 'Senha'),
                                  ),
                                ),
                                Text(_loginMsgController.text),
                                ButtonRounded(
                                    'LOGIN', Colors.orange, () {
                                      _loginFirebase();
                                    }),
                                ButtonRounded(
                                    'OU CRIAR ACESSO', Colors.deepOrange, () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SingupPage()));
                                }),
                                Container(
                                  height: 8,
                                ),
                                Text(
                                  "Esqueceu sua senha?",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: 30,
                                ),
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100))),
                                  child: FlatButton(
                                    onPressed: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => StartPage())),
                                    child: Center(
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
