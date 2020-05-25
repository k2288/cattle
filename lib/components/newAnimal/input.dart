import 'package:flutter/material.dart';

class Input extends StatelessWidget {

  final TextEditingController _controller;
  final String _label;
  final Function _onTab;
  final bool _enable;
  final _focus;
  final Function _changeFieldFocus;
  final bool _isLastItem;
  Input(this._label,this._controller,this._onTab,this._enable,this._focus,this._changeFieldFocus,this._isLastItem);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTab,
      child:TextFormField(
        textInputAction: _isLastItem?TextInputAction.done:TextInputAction.next,
        onFieldSubmitted: _changeFieldFocus,
        focusNode: _focus,
        enabled: _enable,
        onTap: _onTab,
        controller: _controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          labelText: _label,
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }
}