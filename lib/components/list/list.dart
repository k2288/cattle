import 'dart:convert';

import 'package:cattle/components/detail/detail.dart';
import 'package:cattle/components/list/filter.dart';
import 'package:cattle/models/livestock.dart';
import 'package:cattle/repositories/LivstockRespository.dart';
import 'package:cattle/utils/SettingsProvider.dart';
import 'package:cattle/utils/api/Response.dart';
import 'package:cattle/widgets/PinSnackBar.dart';
import 'package:cattle/widgets/fab_bottom_navigation/pin_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:timeago/timeago.dart' as timeago;

class CattleList extends StatefulWidget {

  CattleList({ @required this.title,this.filterData});

  final String title;
  final FilterData filterData;

  @override
  _CattleListState createState() => _CattleListState();
}

class _CattleListState extends State<CattleList> {
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "";
  int _pageSize=10,_offset=-10;
  List<Livestock> _livestockList=new List<Livestock>();
  LivestockRepository _livestockRepository;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  SettingsData _settingData;

  FilterData filterData=FilterData([],[]);

  _CattleListState(){
    _livestockRepository=LivestockRepository();
  }

  @override
  void initState() {
    filterData=widget.filterData;
    loadLivestock();
    _settingData= SettingsProvider().getSettings();
    super.initState();
  }

  Future<void> loadLivestock([bool isRefresh=false])async{
    if(isRefresh){
      setState(() {
        _offset=-10;
        _livestockList.clear();
      });
    }

    var response =await _livestockRepository.getLivestockList({
      "state":filterData.states.length>0?jsonEncode(filterData.states):null ,
      "type":filterData.type.length>0? jsonEncode(filterData.type):null,
      "offset":(_offset+_pageSize).toString(),
      "pageSize":_pageSize.toString(),
      "searchTerm":searchQuery!=""?searchQuery:null
    });
    if(response.status==Status.COMPLETED){
      setState(() {
        _livestockList.addAll(response.data.content) ;
      });

    }else{
      _scaffoldKey.currentState.showSnackBar(PinSnackBar(response.message).get());
    }

  }

  String relativeDate(DateTime dateTime){
    return timeago.format(dateTime,locale: 'fa');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: BackButton(),
        centerTitle: true,
        title: _isSearching?_buildSearchField(): Text(widget.title),
        actions: _buildActions(),
      ),
      body:Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: 
          RefreshIndicator(
            onRefresh:()=>loadLivestock(true),
            child: ListView.builder(
              itemCount: _livestockList.length,
              itemBuilder: (BuildContext buildContext,int index){
                Livestock item=_livestockList[index];
                DateTime tempDate;
                if(item.state!=null){
                  tempDate= DateTime.parse(item.lastStateDate);
                }else{
                  tempDate= DateTime.parse(item.birthDate);
                }
                
                String birthDate="${tempDate.year}/${tempDate.month.toString().padLeft(2,"0")}/${tempDate.day.toString().padLeft(2,"0")}";
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(flex: 2, child: Container(
                            // width: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // color: Color(0xff369ee5)
                            ),
                            margin: EdgeInsets.only(
                              bottom: 5
                            ),
                            padding: EdgeInsets.all(10),
                            child: item.gender!=null && _settingData.livestockType.contains(item.gender)  ? PinImage(url: "/assets/type/${item.gender}.png"):Container()
                          )
                        ),
                        Flexible(flex: 3, child:Container(
                          width: double.infinity,
                          margin: EdgeInsets.all(0),
                          padding: EdgeInsets.only(top:20,bottom:20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(item.gender,style: Theme.of(context).textTheme.display3,),
                              Text(item.tagNo,style: Theme.of(context).textTheme.display2,),
                              
                            ],
                          )
                        )),
                        Flexible(flex: 2, child: Container(
                            
                            padding: EdgeInsets.all(15),
                            child: item.state!=null && _settingData.livestockState.contains(item.state)  ? PinImage(url: "/assets/states/${item.state}.png"):Container(),
                            
                          )
                        ),
                        Flexible(flex: 2, child:Container(
                          width: double.infinity,
                          margin: EdgeInsets.all(0),
                          padding: EdgeInsets.only(top:20,bottom:20,left:5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(child:Text(item.state??"تولد",style: Theme.of(context).textTheme.display3)),
                              Center(child: Text(birthDate,style:TextStyle(fontSize: 12)))
                              
                              // Icon(FontAwesomeIcons.sort,color: Colors.white,)
                            ],
                          )
                        )),
                      ],
                    ),
                    onTap:()=> _onListItemClick(item),
                  ) 
                );
              }
            )
          )
      )
    );
  }

  _onListItemClick(Livestock item)async{
    final deletedItem= await  Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Detail(livestock: item,))
    );

    if(deletedItem!=null ){
      setState(() {
        _livestockList.removeWhere((element) => element.tagNo==deletedItem.tagNo);
      });

    }

  }

  _buildSearchField(){
    return TextField(
      onSubmitted: (query){
        updateSearchQuery(query);
      },
      textInputAction: TextInputAction.search,
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "جستجوی شماره گوش ...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) => {},
    );
  }
  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
      IconButton(
        icon: const Icon(FontAwesome.sliders),
        onPressed: ()=>showFilterHandler(),
      ),
    ];
  }

  showFilterHandler()async{
    FilterData response=await showModalBottomSheet(context: context, builder: (context){
        return Filter(filterData);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
        backgroundColor: Colors.white,
    );
    if(response!=null){
      setState(() {
        filterData=response;
      });
      loadLivestock(true);
    }
  }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
    loadLivestock(true);
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }


}