import 'package:cattle/components/newAnimal/drop_down.dart';
import 'package:cattle/components/newAnimal/input.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:shamsi_date/shamsi_date.dart';


class NewAnimal extends StatefulWidget {
  @override
  _NewAnimalState createState() => _NewAnimalState();
}

class _NewAnimalState extends State<NewAnimal> {

  final _formKey = GlobalKey<FormState>();
  final tagController = TextEditingController();
  final nameController = TextEditingController();
  final birthController = TextEditingController();
  final genderController = TextEditingController();
  final motherController = TextEditingController();
  final inserminatorController = TextEditingController();
  String _genderValue;

  final FocusNode _tagFocus = FocusNode();  
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _birthFocus = FocusNode();
  final FocusNode _genderFocus = FocusNode();
  final FocusNode _motherFocus = FocusNode();
  final FocusNode _inseminatorFocus = FocusNode();

  final FocusScopeNode _node = FocusScopeNode();

  FocusNode currentFocus;
  bool isInitialized=false;

  @override
  void initState() {
    super.initState();


  }

  // _NewAnimalState(){
  //   setState(() {
  //     currentFocus=_tagFocus;
  //   });
  //   FocusScope.of(context).requestFocus(currentFocus);
  // }

  DateTime _birth=DateTime.now();


  List<dynamic> genders =['نر','ماده'];

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
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
              title:Text("دام جدید")
            ),
            SliverPadding(
              padding: EdgeInsets.all(20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Input("شماره تگ",tagController,()=>{},true,_tagFocus,(str)=>_changeFieldFocus(_nameFocus),false),
                  SizedBox(height: 20),
                  Input("نام",nameController,()=>{},true,_nameFocus,(str)=>_changeFieldFocus(_birthFocus),false),
                  SizedBox(height: 20,),
                  Input("تاریخ تولد",birthController,()=>{
                    DatePicker.showDatePicker(context,locale: LocaleType.fa,onConfirm: _confirmBirth,currentTime: _birth)
                  },false,_birthFocus,(str)=>{},false),
                  SizedBox(height: 20,),
                  DropDown(
                    hint: "جنسیت",
                    items: genders,
                    value: _genderValue,
                    onChanged: (value){
                      this.setState((){
                        _genderValue=value;
                      });
                      genderController.text=value;
                      _changeFieldFocus(_motherFocus);
                    },
                    focus: _genderFocus,
                  ),
                  SizedBox(height: 20), 
                  Input("مادر",motherController,()=>{},true,_motherFocus,(str)=>_changeFieldFocus(_inseminatorFocus),false),
                  SizedBox(height: 20),
                  Input("تلقیح کننده",inserminatorController,()=>{},true,_inseminatorFocus,(str)=>{},true),

                  SizedBox(height: 20,),
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Scaffold
                            .of(context)
                            .showSnackBar(SnackBar(content: Text('Processing Data')));
                      }
                    },
                    child: Text('ذخیره دام',style: Theme.of(context).textTheme.button,),
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
    // _node.nextFocus();
    print(nextFocus.toString());
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);  
    setState(() {
      currentFocus=nextFocus;
    });
  }

  _confirmBirth(DateTime date){
    this.setState(()=>{
      _birth=date
    });
    Date jalali=Gregorian.fromDateTime(date).toJalali();
    birthController.text= "${jalali.year}/${jalali.month.toString().padLeft(2,"0")}/${jalali.day.toString().padLeft(2,"0")}" ;
    _changeFieldFocus(_genderFocus);
  }
}