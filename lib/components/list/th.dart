import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Th extends StatelessWidget {

  final String _title;

  Th(this._title);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.only(top:10,bottom: 10,left: 5,right:5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color(0xff369ee5)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(_title,style: Theme.of(context).textTheme.display1,),
          Icon(FontAwesomeIcons.sort,color: Colors.white,)
        ],
      )
    );
  }
}