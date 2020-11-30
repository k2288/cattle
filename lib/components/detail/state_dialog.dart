import 'dart:convert';

import 'package:cattle/components/newAnimal/drop_down.dart';
import 'package:cattle/components/newAnimal/input.dart';
import 'package:cattle/models/LivestockState.dart';
import 'package:cattle/models/LocaleModel.dart';
import 'package:cattle/utils/DateUtil.dart';
import 'package:cattle/utils/SettingsProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persian_date/persian_date.dart';
import 'package:persian_datepicker/persian_datepicker.dart';
import 'package:persian_datepicker/persian_datetime.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class StateDialog extends StatefulWidget {

  final LivestockState _livestockState;
  final Function _saveStateHandler;

  StateDialog(this._livestockState,this._saveStateHandler);


  @override
  _StateDialogState createState() => _StateDialogState();
}

class _StateDialogState extends State<StateDialog> {

  PersianDatePickerWidget persianDatePicker;
  final stateDateController = TextEditingController();
  final descriptionController = TextEditingController();
  final stateController = TextEditingController();
  
  String stateValue;

  @override
  void initState() {

    Future.delayed(Duration.zero,(){
      if(widget._livestockState.date!=null){
        stateDateController.text= DateUtil.formatLocaleDate(widget._livestockState.date, context) ;
      }else{
    
        stateDateController.text=DateUtil.formatLocaleDate(DateTime.now().toString(), context) ;  
      }
    });


    
    persianDatePicker = PersianDatePicker(
      controller: stateDateController,
    ).init();

    stateValue=widget._livestockState.state;
    stateController.text=widget._livestockState.state;
    descriptionController.text=widget._livestockState.description;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ), 
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    ));
  }

  dialogContent(BuildContext context) {
    // setState(() {
    //   stateValue=value;
    // });
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top:  Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              DropDown(
                hint: AppLocalizations.of(context).state_dialog_type,
                items: SettingsProvider().getSettings().livestockState.map((item){
                      return DropdownMenuItem<String>(
                        child: Text(jsonDecode(item.title)[Localizations.localeOf(context).languageCode]),
                        value: item.value
                      );
                    }).toList(),
                value: stateValue,
                onChanged: (newValue){
                  print(newValue);
                  setState((){
                    stateValue=newValue;
                  });
                  stateController.text=newValue;
                },
                focus: null,
              ),
              SizedBox(height: 24.0),
              Input(AppLocalizations.of(context).state_dialog_date,stateDateController,() async {
                  if(Language.isRtl(context)){
                    FocusScope.of(context).requestFocus(new FocusNode()); // to prevent opening default keyboard
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return persianDatePicker;
                      });
                    
                  }else{
                    final DateTime picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.parse(stateDateController.text),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2025),
                      );
                      if(picked != null)
                        stateDateController.text= DateFormat("yyyy-MM-dd").format(picked);
                  }
                },false,null,(str)=>{},false),
              SizedBox(height: 24.0),
              Input(AppLocalizations.of(context).state_dialog_description,descriptionController,()=>{},true,null,(str)=>{},true),

              SizedBox(height: 24.0),
              Row(
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                      onPressed: () async{
                        
                        var body=<String,dynamic>{
                          "state":stateController.text,
                          "date":Language.isRtl(context) ? PersianDateTime(jalaaliDateTime: stateDateController.text).toGregorian():stateDateController.text ,
                          "description":descriptionController.text,
                          "id":widget._livestockState.id
                        };
                        widget._saveStateHandler(body);                    
                      },
                      child: Text(AppLocalizations.of(context).state_dialog_save),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: Text(AppLocalizations.of(context).state_dialog_cancel),
                    ),
                  ),
                ],
              )
              
            ],
          ),
        ),

      ],
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}