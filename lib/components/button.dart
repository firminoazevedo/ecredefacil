import 'package:flutter/material.dart';


class ButtonRounded extends StatelessWidget {
  final Function f;
  final Color color;
  final String text;
  ButtonRounded(this.text, this.color, this.f);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 20, left: 20, top: 10),
      child: RaisedButton(
          onPressed: f,
          elevation: 0,
          color: color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),),
          child: Center(
            child: Container(
              margin: EdgeInsets.all(12),
              child: Text(
                text,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
    );
  }
}