import 'package:flutter/material.dart';

class Td extends StatelessWidget {

  final String _value;

  Td(this._value);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.only(top:20,bottom:20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(_value,style: Theme.of(context).textTheme.display2,),
          // Icon(FontAwesomeIcons.sort,color: Colors.white,)
        ],
      )
    );
  }
}