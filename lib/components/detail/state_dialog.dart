import 'dart:convert';

import 'package:cattle/components/newAnimal/drop_down.dart';
import 'package:cattle/components/newAnimal/input.dart';
import 'package:cattle/models/LivestockState.dart';
import 'package:cattle/utils/SettingsProvider.dart';
import 'package:cattle/utils/api/Response.dart';
import 'package:flutter/material.dart';
import 'package:persian_datepicker/persian_datepicker.dart';
import 'package:shamsi_date/shamsi_date.dart';

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

    if(widget._livestockState.date!=null){
      DateTime jalali = DateTime.parse(widget._livestockState.date);
      stateDateController.text="${jalali.year}/${jalali.month.toString().padLeft(2,"0")}/${jalali.day.toString().padLeft(2,"0")}" ;
    }else{
      Date jalali=Gregorian.fromDateTime(DateTime.now()).toJalali();
      stateDateController.text= "${jalali.year}/${jalali.month.toString().padLeft(2,"0")}/${jalali.day.toString().padLeft(2,"0")}" ;
    }
    
    

  

    
    persianDatePicker = PersianDatePicker(
      controller: stateDateController,
      // datetime: widget._livestockState.date,
    ).init();

    stateValue=widget._livestockState.state;
    stateController.text=widget._livestockState.state;

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
                hint: "نوع",
                items: SettingsProvider().getSettings().livestockState,
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
              Input("تاریخ ",stateDateController,()=>{
                    
                  FocusScope.of(context).requestFocus(new FocusNode()), // to prevent opening default keyboard
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return persianDatePicker;
                    })
                    // DatePicker.showDatePicker(context,locale: LocaleType.fa,onConfirm: _confirmStateDate,currentTime: stateDate)

                  },false,null,(str)=>{},false),
              SizedBox(height: 24.0),
              Input("توضیحات",descriptionController,()=>{},true,null,(str)=>{},true),

              SizedBox(height: 24.0),
              Row(
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                      onPressed: () async{
                        
                        var body=<String,dynamic>{
                          "state":stateController.text,
                          "date":stateDateController.text,
                          "description":descriptionController.text,
                          "id":widget._livestockState.id
                        };
                        

                        widget._saveStateHandler(body);                    
                      },
                      child: Text("تایید"),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: Text("لغو"),
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