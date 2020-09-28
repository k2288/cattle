

import 'package:cattle/components/dashboard/summary_card.dart';
import 'package:cattle/components/detail/state_dialog.dart';
import 'package:cattle/models/LivestockState.dart';
import 'package:cattle/models/livestock.dart';
import 'package:cattle/repositories/LivstockRespository.dart';
import 'package:cattle/utils/SettingsProvider.dart';
import 'package:cattle/utils/api/Response.dart';
import 'package:cattle/widgets/PinSnackBar.dart';
import 'package:cattle/widgets/confirm_dialog.dart';
import 'package:cattle/widgets/fab_bottom_navigation/pin_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persian_datepicker/persian_datepicker.dart';



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

  LivestockRepository _livestockRepository;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime birthDate;

  _DetailState(){
    _livestockRepository=LivestockRepository();
  }
  
  @override
  void initState() {

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

  showDeleteDialog(Function confirmDelete,[dynamic item]){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDialog(confirmDelete, "هشدار", "آیا از حذف این مورد مطمئن هستید",item: item);
      },
    );
  }

  confirmDeleteLivestock()async{
    var response=await _livestockRepository.deleteLivestock(widget.livestock.id);
    if(response.status==Status.COMPLETED){
    Navigator.of(context).pop();
    Navigator.of(context).pop(widget.livestock);
    }else{
      Navigator.of(context).pop();
    _scaffoldKey.currentState.showSnackBar(PinSnackBar(response.message).get());

    }
  }

  void _select(String value){
    LivestockState livestockState=LivestockState(value,null,"123");
    showDialog(
      context: context,
      child: StateDialog(livestockState,saveStateHandler)
    );
  }

  saveStateHandler(body)async{

    Response response= await _livestockRepository.postState(widget.livestock.id, body);

    if(response.status==Status.COMPLETED){
      setState(() {
        _logs.insert(0, response.data);
      });
      Navigator.of(context).pop(); 
    }else{
      Navigator.of(context).pop(); 
      _scaffoldKey.currentState.showSnackBar(PinSnackBar(response.message).get());
    }
  }

  updateStateHandler(body)async{
    Response response= await _livestockRepository.putState(widget.livestock.id, body);  
    
    if(response.status==Status.COMPLETED){
      int index= _logs.indexWhere((element) => element.id==body["id"]);
      LivestockState state=LivestockState(body["state"],body["date"].toString().replaceAll("/","-"),body["description"],body["id"]);
      setState(() {
        _logs[index]=state;
      });
      Navigator.of(context).pop(); 
    }else{
      Navigator.of(context).pop(); 
      _scaffoldKey.currentState.showSnackBar(PinSnackBar(response.message).get());
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title:Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Icon(FontAwesome.tag,color: Colors.yellow,),
            Text(" ${widget.livestock.tagNo}"),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed:()=> showDeleteDialog(confirmDeleteLivestock)
          ),
          // SvgPicture.asset("assets/images/dry_cow.svg",fit:BoxFit.contain ,color: Colors.white,),
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
          physics: AlwaysScrollableScrollPhysics(),
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
                  childAspectRatio: 4/3,                
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    SummaryCard(0,"تولد",  "${birthDate.year}/${birthDate.month}/${birthDate.day}",),
                    SummaryCard(1,"جنسیت", widget.livestock.gender.toString()),
                    SummaryCard(2,'مادر', widget.livestock.mother),
                    SummaryCard(3,'تلقیح کننده', widget.livestock.inseminator),
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
                      onTap: (){    
                        showDialog(
                          context: context,
                          child: StateDialog(item,updateStateHandler)
                          
                        );
                      },
                      child: Row(
                        children: <Widget>[
                          Flexible(flex: 2, child: Container(
                            // width: 10,
                            padding: EdgeInsets.all(20),
                            child: PinImage(url: "/assets/states/${item.state}.png")

                          )
                        ),
                        Flexible(flex: 1, child:Container(
                          width: double.infinity,
                          margin: EdgeInsets.all(0),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(item.state,style: Theme.of(context).textTheme.display3,),
                            ],
                          )
                        )),
                        Flexible(flex: 3, child:Container(
                          width: double.infinity,
                          margin: EdgeInsets.all(0),
                          padding: EdgeInsets.only(top:20,bottom:20,left:10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(child:Text("${date.year}/${date.month.toString().padLeft(2,"0")}/${date.day.toString().padLeft(2,"0")}",style: Theme.of(context).textTheme.display3,)),
                            ],
                          )
                        )),
                        Flexible(flex: 1, child:Container(
                          width: double.infinity,
                          margin: EdgeInsets.all(0),
                          padding: EdgeInsets.only(top:20,bottom:20,left:10),
                          child: IconButton(
                            color: Colors.red,
                            icon: const Icon(Icons.delete),
                            onPressed:  ()=>showDeleteDialog(confirmLivestockStateDelete,item),
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

  confirmLivestockStateDelete(item)async{
    var response=await _livestockRepository.deleteLivestockState(widget.livestock.id, item.id);
    if(response.status==Status.COMPLETED){
      setState(() {
        _logs.removeWhere((element) => element.id==item.id);
      });
      Navigator.of(context).pop();
    }else{
      _scaffoldKey.currentState.showSnackBar(PinSnackBar(response.message).get());
      Navigator.of(context).pop();
    }
  }
}