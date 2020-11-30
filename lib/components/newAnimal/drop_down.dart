import 'package:flutter/material.dart';

class DropDown extends StatelessWidget {
  final String value;
  final String hint;
  
  final List<DropdownMenuItem<String>> items;
  final Function onChanged;

  final focus;
  final Function changeFieldFocus;

  const DropDown(
      {Key key,
      this.value,
      this.hint,
      this.items,
      this.onChanged,
      this.focus,
      this.changeFieldFocus
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            // color: Colors.grey[100], 
            borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 5),
            child: DropdownButton<String>(
              focusNode: focus,
              value: value,
              hint: Text(
                hint,
              ),
              items:items,
              onChanged: (item) {
                onChanged(item);
              },
              isExpanded: true,
              underline: Container(),
              icon: Icon(Icons.chevron_right),
            ),
          ),
        ),

      ],
    );
  }
}