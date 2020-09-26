import 'package:flutter/material.dart';

class PinSnackBar {

  final String _text;

  PinSnackBar(this._text);

  SnackBar get(){
    return SnackBar(
      content: Text(_text,style: TextStyle(color: Colors.white,fontFamily: "Iran_Sans"),),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
    );
  }

}