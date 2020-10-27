import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linhares/components/gridDashBord.dart';
import 'package:linhares/providers/auth.dart';
import 'package:provider/provider.dart';

class HomeDoisPage extends StatefulWidget {
  @override
  _HomeDoisPageState createState() => _HomeDoisPageState();
}

class _HomeDoisPageState extends State<HomeDoisPage> {

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context);
    // ignore: unused_local_variable
    String email = auth.email;
    final TextEditingController _valorDesejadoController = TextEditingController();

    return Column(
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'email',
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w300)),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Home",
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              IconButton(
                alignment: Alignment.topCenter,
                icon: Icon(
                  Icons.mail,
                  color: Colors.white,
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: TextField(
            controller: _valorDesejadoController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
                filled: true,
                labelText: 'Digite o valor desejado',
                hintText: 'R\$ 3000,00',
                fillColor: Colors.white),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        GridDashboard(_valorDesejadoController),
      ],
    );
  }
}
