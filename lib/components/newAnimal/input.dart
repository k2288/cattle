import 'package:flutter/material.dart';

class Input extends StatelessWidget {

  final TextEditingController _controller;
  final String _label;
  final VoidCallback? _onTab;
  final bool _enable;
  final FocusNode? _focus;
  final ValueChanged<String>? _changeFieldFocus;
  final bool _isLastItem;
  const Input(this._label,this._controller,this._onTab,this._enable,this._focus,this._changeFieldFocus,this._isLastItem, {super.key});

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
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }
}