import 'dart:convert';

import 'package:cattle/components/detail/detail.dart';
import 'package:cattle/components/newAnimal/drop_down.dart';
import 'package:cattle/components/newAnimal/input.dart';
import 'package:cattle/models/livestock.dart';
import 'package:cattle/repositories/LivstockRespository.dart';
import 'package:cattle/utils/SettingsProvider.dart';
import 'package:cattle/utils/api/Response.dart';
import 'package:flutter/material.dart';
import 'package:persian_datepicker/persian_datepicker.dart';
import 'package:persian_datepicker/persian_datetime.dart';



class NewAnimal extends StatefulWidget {

  Livestock livestock;
  NewAnimal({this.livestock});

  @override
  _NewAnimalState createState() => _NewAnimalState();
}

class _NewAnimalState extends State<NewAnimal> {

  LivestockRepository _livestockRepository;

  final _formKey = GlobalKey<FormState>();
  final tagController = TextEditingController();
  final birthController = TextEditingController();
  final genderController = TextEditingController();
  final stateController = TextEditingController();
  final motherController = TextEditingController();
  final inserminatorController = TextEditingController();
  String _genderValue;
  String _stateValue;

  final FocusNode _tagFocus = FocusNode();  
  final FocusNode _birthFocus = FocusNode();
  final FocusNode _genderFocus = FocusNode();
  final FocusNode _stateFocus = FocusNode();
  final FocusNode _motherFocus = FocusNode();
  final FocusNode _inseminatorFocus = FocusNode();

  final FocusScopeNode _node = FocusScopeNode();

  PersianDatePickerWidget persianDatePicker;


  FocusNode currentFocus;
  bool isInitialized=false;
  List<dynamic> genders =['نر','ماده'];
  List<dynamic> states =[];//=['نوع ۲','نوع ۱'];
  DateTime _birth=DateTime.now();
  

  @override
  void initState() {

    if(widget.livestock!=null){
      tagController.text=widget.livestock.tagNo;
      birthController.text=widget.livestock.birthDate;
      genderController.text=widget.livestock.gender;
      _genderValue=widget.livestock.gender;
      motherController.text=widget.livestock.mother;
      inserminatorController.text=widget.livestock.inseminator;
    }

    persianDatePicker = PersianDatePicker(
      controller: birthController,
//      datetime: '1397/06/09',
    ).init();

    states=SettingsProvider().getSettings().livestockState;
    super.initState();
  }

  _NewAnimalState(){
    _livestockRepository=LivestockRepository();
    // setState(() {
    //   currentFocus=_tagFocus;
    // });
    // FocusScope.of(context).requestFocus(currentFocus);
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized && widget.livestock==null) {
      isInitialized = true;
      setState(() {
        currentFocus=_tagFocus;
      });
      FocusScope.of(context).requestFocus(_tagFocus);
    }
    return Scaffold(
      body: Form(
        child:CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              leading: BackButton(),
              centerTitle: true,
              title:Text(widget.livestock!=null?
                "ویرایش دام"
                :"دام جدید"
              )
            ),
            SliverPadding(
              padding: EdgeInsets.all(20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Input("شماره تگ",tagController,()=>{},true,_tagFocus,(str)=>_changeFieldFocus(_birthFocus),false),
                  SizedBox(height: 20),
                  Input("تاریخ تولد",birthController,()=>{
                    FocusScope.of(context).requestFocus(new FocusNode()), // to prevent opening default keyboard
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return persianDatePicker;
                    })

                  },false,_birthFocus,(str)=>{},false),
                  SizedBox(height: 20,),
                  DropDown(
                    hint: "جنسیت",
                    items: genders,
                    value: _genderValue,
                    onChanged: (value){
                      setState((){
                        _genderValue=value;
                      });
                      genderController.text=value;
                      // _changeFieldFocus(_motherFocus);
                    },
                    focus: _genderFocus,
                  ),
                  SizedBox(height: 20), 
                  // DropDown(
                  //   hint: "وضعیت",
                  //   items:states ,
                  //   value: _stateValue,
                  //   onChanged: (value){
                  //     this.setState((){
                  //       _stateValue=value;
                  //     });
                  //     stateController.text=value;
                  //     _changeFieldFocus(_motherFocus);
                  //   },
                  //   focus: _stateFocus,
                  // ),
                  SizedBox(height: 20), 
                  Input("مادر",motherController,()=>{},true,_motherFocus,(str)=>_changeFieldFocus(_inseminatorFocus),false),
                  SizedBox(height: 20),
                  Input("تلقیح کننده",inserminatorController,()=>{},true,_inseminatorFocus,(str)=>{},true),

                  SizedBox(height: 20,),
                  Builder(
                    builder: (context){
                      return RaisedButton(
                        color: Theme.of(context).primaryColor,
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        onPressed: () async {

                          

                          var body=jsonEncode(<String, dynamic>{
                            "tagNo":tagController.text,
                            "birthDate":PersianDateTime(jalaaliDateTime: birthController.text).toGregorian(),
                            "gender":genderController.text,
                            "mother":motherController.text,
                            "inseminator":inserminatorController.text,
                            "_id":widget.livestock!=null?widget.livestock.id:null
                            // "state":stateController.text,
                          });
                          
                          var response;
                          if(widget.livestock!=null){
                            response=await _livestockRepository.putLivestock(widget.livestock.id,body);
                          }else{
                            response=await _livestockRepository.postLivestock(body);
                          }

                          if(response.status==Status.COMPLETED){
                            if(widget.livestock!=null){
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Detail(livestock: response.data,)));
                            }else{
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Detail(livestock: response.data,)));
                            }
                            
                          }else{
                            Scaffold
                              .of(context)
                              .showSnackBar(SnackBar(
                                  content: Text(response.message,style: TextStyle(color: Colors.white,fontFamily: "Iran_Sans"),),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.red,
                                )
                              );
                          }

                          // var response = await http.post("${FlutterConfig.get('API_URL')}/v1/livestock", body:body);
                          // if (_formKey.currentState.validate()) {
                          //   Scaffold
                          //       .of(context)
                          //       .showSnackBar(SnackBar(content: Text('Processing Data')));
                          // }
                        },
                        child: Text('ذخیره دام',style: Theme.of(context).textTheme.button),
                      );
                    }
                  )
                  
                ]),
              )
            )
          ],
        ),
      )
    );
  }

  _changeFieldFocus(FocusNode nextFocus){
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);  
    setState(() {
      currentFocus=nextFocus;
    });
  }

}