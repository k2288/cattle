import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConfirmDialog extends StatelessWidget {

  final Function _confirmDelete;
  final String _title;
  final String _description;
  final dynamic item;

  ConfirmDialog(this._confirmDelete,this._title,this._description,{this.item});


  @override
  Widget build(BuildContext context) {

    Widget cancelButton = FlatButton(
      child: Text(AppLocalizations.of(context).confirm_dialog_no,style: TextStyle(color: Colors.black),),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text(AppLocalizations.of(context).confirm_dialog_yes,style: TextStyle(color: Colors.black),),
      onPressed:  (){
        if(item!=null){
          print(1);
          _confirmDelete(item);
        }else{
          print(2);
          _confirmDelete();
        }
      },
    );

        // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(_title),
      content: Text(_description),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    return alert;
  }
}