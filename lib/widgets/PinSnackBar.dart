import 'package:flutter/material.dart';

class PinSnackBar {

  final String _text;
  final Duration _duration;

  PinSnackBar(this._text,[this._duration = const Duration(seconds: 4)]);

  SnackBar get(){
    return SnackBar(
      duration: _duration,
      content: Text(_text,style: TextStyle(color: Colors.white,fontFamily: "Iran_Sans"),),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
    );
  }

}