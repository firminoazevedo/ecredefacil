import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:linhares/animation/FadeAnimation.dart';
import 'package:linhares/components/button.dart';
import 'package:linhares/exceptions/firabese_exceptions.dart';
import 'package:linhares/providers/auth.dart';
import 'package:linhares/screens/login.dart';
import 'package:linhares/screens/profileCreate.dart';
import 'package:linhares/screens/startScreen.dart';
import 'package:provider/provider.dart';

class SingupPage extends StatefulWidget {
  @override
  _SingupPageState createState() => _SingupPageState();
}

class _SingupPageState extends State<SingupPage> {
  AuthResult _authResult;
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  final TextEditingController _loginMsgController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  Future<void> _signUpFirebase() async {
    try {
      setState(() {
        _isLoading = true;
      });
      /*_authResult = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);*/
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ProfileCreatePage('_authResult.user.uid')));
    } on PlatformException catch (err) {
      _showErrorDialog(err.code);
    } catch (error) {
      print(error);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _singUpHttp() async {
    Auth auth = Provider.of(context, listen: false);
    try {
      await auth.singup(_emailController.text, _passwordController.text);
    } on AuthExceptionHttp catch (error) {
      _showErrorDialog(error.toString());
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          child: Container(
            color: Colors.green,
            child: FadeAnimation(
              1.4,
              Column(
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
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'CADASTRAR-SE',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
                                icon: Icon(Icons.person), hintText: 'Email')),
                        Padding(
                          padding: EdgeInsets.only(top: 16, bottom: 16),
                          child: TextField(
                            obscureText: true,
                            controller: _passwordController,
                            decoration: InputDecoration(
                                icon: Icon(Icons.lock), hintText: 'Senha'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 32),
                          child: TextField(
                            obscureText: true,
                            controller: _repeatPasswordController,
                            decoration: InputDecoration(
                                icon: Icon(Icons.lock),
                                hintText: 'Repita a senha'),
                          ),
                        ),
                        Text(_loginMsgController.text),
                        ButtonRounded('CRIAR ACESSO', Colors.orange, () {
                          _signUpFirebase();
                        }),
                        ButtonRounded('OU ENTRAR', Colors.deepOrange, () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginPage()));
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
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
