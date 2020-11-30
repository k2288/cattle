import 'package:flutter/material.dart';

class PinSnackBar {

  final String _text;
  final Duration _duration=Duration(seconds: 4);

  PinSnackBar(this._text,[_duration,]);

  SnackBar get(){
    return SnackBar(
      duration: _duration,
      content: Text(_text,style: TextStyle(color: Colors.white,fontFamily: "Iran_Sans"),),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
    );
  }

}