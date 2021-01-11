import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Rodape extends StatefulWidget {
  int _indexPage;
  PageController _pageController;
  Rodape(this._indexPage, this._pageController);
  @override
  _RodapeState createState() => _RodapeState(_indexPage, _pageController);
}

class _RodapeState extends State<Rodape> {
  int _indexPage;
  PageController _pageController;
  _RodapeState(this._indexPage, this._pageController);
  List<String> pages = ['Home', 'Empréstimos', 'Indicações', 'Minha conta'];
  String title = 'Home';
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
          ]);
  }
}