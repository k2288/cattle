import 'dart:convert';
import 'dart:math';

import 'package:cattle/components/dashboard/summary_card.dart';
import 'package:cattle/components/newAnimal/input.dart';
import 'package:cattle/models/LivestockState.dart';
import 'package:cattle/models/livestock.dart';
import 'package:cattle/repositories/LivstockRespository.dart';
import 'package:cattle/utils/SettingsProvider.dart';
import 'package:cattle/utils/api/Response.dart';
import 'package:cattle/widgets/PinSnackBar.dart';
import 'package:cattle/widgets/fab_bottom_navigation/pin_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:persian_datepicker/persian_datepicker.dart';
import 'package:shamsi_date/shamsi_date.dart';



class Detail extends StatefulWidget {
  Livestock livestock;

  Detail({this.livestock});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {

  ScrollController scrollController;

  PersianDatePickerWidget persianDatePicker;


  List<LivestockState> _logs=List<LivestockState>();
  int _pageSize=10,_offset=-10,_totalItems=0;
  bool _loading=true;


  final stateDateController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime stateDate=DateTime.now();

  LivestockRepository _livestockRepository;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime birthDate;

  _DetailState(){
    _livestockRepository=LivestockRepository();
  }
  
  @override
  void initState() {

    persianDatePicker = PersianDatePicker(
      controller: stateDateController,
    ).init();

    scrollController = new ScrollController()..addListener(_scrollListener);
    birthDate=DateTime.parse(widget.livestock.birthDate);
    loadLogs();
    super.initState();
  }


  void _scrollListener() {
  
    if (scrollController.position.extentAfter < 300 && _totalItems>_offset+_pageSize && _loading==false ) {
      loadLogs();
    }
  }

  loadLogs([bool refresh=false])async{
    setState(() {
      _loading=true;
    });

    if(refresh){
      setState(() {
        _offset=-10;
        _logs.clear();
      });
    }

    var response= await _livestockRepository.getStates(widget.livestock.id,
    {
      "offset":(_offset+_pageSize).toString(),
      "pageSize":_pageSize.toString()
    });
    if(response.status==Status.COMPLETED){
      setState(() {
        _logs.addAll(response.data.content);  
        _offset=response.data.offset;
        _pageSize=response.data.pageSize;
        _totalItems=response.data.totalElements;
        _loading=false;

      });
      
    }else{
      _scaffoldKey.currentState.showSnackBar(PinSnackBar(response.message).get());
    }
  }
  
  Future<void> refresh()async{
    await loadLogs(true);
  }

  showDeleteDialog(){
    Widget cancelButton = FlatButton(
      child: Text("خیر"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("بلی"),
      onPressed:  ()async {
         var response=await _livestockRepository.deleteLivestock(widget.livestock.id);
         if(response.status==Status.COMPLETED){
          Navigator.of(context).pop();
          Navigator.of(context).pop(widget.livestock);
         }else{
           Navigator.of(context).pop();
          _scaffoldKey.currentState.showSnackBar(PinSnackBar(response.message).get());

         }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("هشدار"),
      content: Text("آیا از حذف این مورد مطمئن هستید"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  
  void _select(String value){

    Date jalali=Gregorian.fromDateTime(stateDate).toJalali();
    stateDateController.text= "${jalali.year}/${jalali.month.toString().padLeft(2,"0")}/${jalali.day.toString().padLeft(2,"0")}" ;

    showDialog(
      context: context,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ), 
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: dialogContent(context,value),
      )
    );
  }

  dialogContent(BuildContext context,String value) {
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
              Input("توضیحات",descriptionController,()=>{},true,null,(str)=>{},false),

              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: () async{
                    
                    var body=jsonEncode(<String,dynamic>{
                      "state":value,
                      "date":stateDateController.text,
                      "description":descriptionController.text
                    });

                    var response= await _livestockRepository.postState(widget.livestock.id, body);

                    if(response.status==Status.COMPLETED){
                      setState(() {
                        _logs.insert(0, response.data);
                      });
                      Navigator.of(context).pop(); // To close the dialog  
                    }else{
                      _scaffoldKey.currentState.showSnackBar(PinSnackBar(response.message).get());
                    }

                    
                  },
                  child: Text("تایید"),
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }





  _confirmStateDate(DateTime date){
    print(date);
    this.setState((){
      stateDate=date;
    });
    Date jalali=Gregorian.fromDateTime(date).toJalali();
    stateDateController.text= "${jalali.year}/${jalali.month.toString().padLeft(2,"0")}/${jalali.day.toString().padLeft(2,"0")}" ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title:Text("${widget.livestock.name} | ${widget.livestock.tagNo}"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: showDeleteDialog,
          ),
          PopupMenuButton(
            offset: Offset(0,10),
            // elevation: 3.2,
            initialValue: SettingsProvider().getSettings().livestockState[0],
            onCanceled: () {
              print('You have not chossed anything');
            },
            tooltip: 'This is tooltip',
            onSelected: _select,
            itemBuilder: (BuildContext context) {
              return SettingsProvider().getSettings().livestockState.map((String choice) {
                return PopupMenuItem(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )

        ],
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: SingleChildScrollView(
          controller: scrollController,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                  height: 10,
                ),
                Text("مشخصات",style: Theme.of(context).textTheme.title),
                SizedBox(
                  height: 10,
                ),
                GridView.count(
                  crossAxisCount: 3,
                  // padding: _topBottomPadding,
                  // crossAxisSpacing: 2,
                  // mainAxisSpacing: 2,
                  childAspectRatio: 4/3,                
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    SummaryCard(0,"تولد",  "${birthDate.year}/${birthDate.month}/${birthDate.day}",),
                    SummaryCard(1,"جنسیت", widget.livestock.gender.toString()),
                    SummaryCard(2,'مادر', widget.livestock.mother),
                    SummaryCard(3,'تلقیح کننده', widget.livestock.inseminator),
                    SummaryCard(4,"وزن", ""),
                    SummaryCard(5,"تعداد شکم", ""),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  primary: false,
                  itemCount: _logs.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext buildcontext,int index){
                  LivestockState item=_logs[index];
                  DateTime date=DateTime.parse(item.date);
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[200],
                          blurRadius: .5,
                          spreadRadius: .2,
                          offset: Offset(
                            1,
                            1
                          )
                        )
                      ]
                    ),
                    margin: EdgeInsets.only(
                      // left: 5,
                      // right: 5,
                      top:1
                    ),
                    child: InkWell(
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(flex: 2, child: Container(
                            // width: 10,
                            padding: EdgeInsets.all(20),
                            child: PinImage(url: "/assets/states/${item.state}.png")
                            // Center(child: Baseline(baseline: 14, baselineType: TextBaseline.alphabetic, child: Text(item._state,style: Theme.of(context).textTheme.display1,),) ,) ,
                          )
                        ),
                        Flexible(flex: 3, child:Container(
                          width: double.infinity,
                          margin: EdgeInsets.all(0),
                          // padding: EdgeInsets.only(top:20,bottom:20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(item.state,style: Theme.of(context).textTheme.display3,),
                              // Text(item._gene,style: Theme.of(context).textTheme.display3,),
                              
                              // Icon(FontAwesomeIcons.sort,color: Colors.white,)
                            ],
                          )
                        )),
                        // Flexible(flex: 2, child: Container(
                        //     // width: 10,
                        //     // decoration: BoxDecoration(
                        //     //   shape: BoxShape.circle,
                        //     //   color: Color(0xff369ee5)
                        //     // ),
                        //     // margin: EdgeInsets.all(5),
                        //     padding: EdgeInsets.all(15),
                        //     child: Image.asset("assets/images/state/${item._service}.png")
                        //     // Center(child: Baseline(baseline: 14, baselineType: TextBaseline.alphabetic, child: Text(item._state,style: Theme.of(context).textTheme.display1,),) ,) ,
                        //   )
                        // ),
                        Flexible(flex: 3, child:Container(
                          width: double.infinity,
                          margin: EdgeInsets.all(0),
                          padding: EdgeInsets.only(top:20,bottom:20,left:10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(child:Text("${date.year}/${date.month.toString().padLeft(2,"0")}/${date.day.toString().padLeft(2,"0")}",style: Theme.of(context).textTheme.display3,)),
                              // Center(child: Text(item._age,style:TextStyle(fontSize: 12)))
                              
                              // Icon(FontAwesomeIcons.sort,color: Colors.white,)
                            ],
                          )
                        )),
                        ],
                      ),
                    ),
                  );
                })
            ],
          ),
        ),
      )
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}