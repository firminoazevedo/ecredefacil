import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linhares/screens/amigos.dart';
import 'package:linhares/screens/amigosFirebase.dart';
import 'package:linhares/screens/emprestimosScreen.dart';
import 'package:linhares/screens/homeDois.dart';
import 'package:linhares/screens/profile.dart';
import 'package:linhares/screens/startScreen.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {
  List<String> pages = ['Home', 'Empréstimos', 'Indicações', 'Minha conta'];
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
        controller: _pageController,
        children: [
          HomeDoisPage(),
          //EmprestimosPage(),
          AmigosFirebasePage(),
          ProfilePage()
        ],
      ),
      drawer: Drawer(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 30,),
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
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.green,
          unselectedItemColor: Colors.grey,
          fixedColor: Colors.green,
          currentIndex: _indexPage,
          onTap: (page) {
            setState(() {
              _indexPage = page;
              title = pages[page];
            });
            _pageController.animateToPage(page,
                duration: Duration(seconds: 1), curve: Curves.decelerate);
          },
          items: [
            BottomNavigationBarItem(
                // ignore: deprecated_member_use
                icon: Icon(Icons.home),
                // ignore: deprecated_member_use
                title: Text('Home')),
            BottomNavigationBarItem(
                icon: Icon(Icons.format_align_justify),
                // ignore: deprecated_member_use
                title: Text('Emprestimos')),
            BottomNavigationBarItem(
                // ignore: deprecated_member_use
                icon: Icon(Icons.group),
                // ignore: deprecated_member_use
                title: Text('Indicados')),
            BottomNavigationBarItem(
                // ignore: deprecated_member_use
                icon: Icon(Icons.person_outline),
                // ignore: deprecated_member_use
                title: Text('Minha Conta')),
          ]),
    );
  }
}
