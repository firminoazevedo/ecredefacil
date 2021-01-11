import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linhares/components/rodape.dart';
import 'package:linhares/screens/indicados.dart';
import 'package:linhares/screens/emprestimosScreen.dart';
import 'package:linhares/screens/homeDois.dart';
// ignore: unused_import
import 'package:linhares/screens/profile.dart';
import 'package:linhares/screens/startScreen.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {
  String title = 'Home';
  PageController _pageController;
  int _indexPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[800],
      appBar: AppBar(
        title: Text(
          "É crédito é facil",
          style: GoogleFonts.openSans(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ),
        elevation: 0,
        backgroundColor: Colors.green[800],
      ),
      body: PageView(
        pageSnapping: false,
        controller: _pageController,
        children: [
          HomeDoisPage(),
          EmprestimosPage(),
          AmigosPage(),
          ProfilePage(),
        ],
      ),
      drawer: Drawer(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Divider(),
              Center(
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => StartPage(),
                      ));
                    },
                    child: Text('Sair')),
              ),
              Divider(),
            ],
          ),
        ),
      ),

      // 
      bottomNavigationBar: Rodape(_indexPage, _pageController),
    );
  }
}
