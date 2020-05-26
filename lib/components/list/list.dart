import 'dart:math';
import 'package:cattle/components/detail/detail.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';


class ListItem{
  final String _state;
  final String _earId;
  final String _gene;
  final String _age;
  final String _service;
  ListItem(this._state,this._earId,this._gene,this._age,this._service);
}

class CattleList extends StatefulWidget {

  CattleList({ @required this.title});

  final String title;

  @override
  _CattleListState createState() => _CattleListState();
}

class _CattleListState extends State<CattleList> {
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "";

  List<String> state=["assets/images/state/bull.png","assets/images/state/calf.png",
  "assets/images/state/cow.png","assets/images/state/heifer.png"];

  static List<String> service=["breeding","calved","onmilking","pragnent","weaned"];

  final List<ListItem> _items=List<ListItem>.generate(50,(i){
    DateTime date= faker.date.dateTime();
    return ListItem(faker.currency.code(),faker.guid.guid().substring(0,3),faker.person.firstName(),
    "${date.month.toString()}ماه ${date.day}روز",
    service[Random().nextInt(5)]);
  } );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        centerTitle: true,
        title: _isSearching?_buildSearchField(): Text(widget.title),
        actions: _buildActions(),
      ),
      body:Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: 
          // Container(
          //   margin: EdgeInsets.only(top:10),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: <Widget>[
          //       Flexible(flex: 1, child: Th("وضعیت")),
          //       Flexible(flex: 1, child: Th("ش.گوش")),
          //       Flexible(flex: 1, child: Th("ژن")),
          //       Flexible(flex: 1, child: Th("سن")),
          //     ],
          //   ),
          // ),
          Center(
            child: ListView.builder(

              itemBuilder: (BuildContext buildContext,int index){
                ListItem item=_items[index];
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
                            child: Image.asset(state[Random().nextInt(3)])
                            // Center(child: Baseline(baseline: 14, baselineType: TextBaseline.alphabetic, child: Text(item._state,style: Theme.of(context).textTheme.display1,),) ,) ,
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
                              Text(item._gene,style: Theme.of(context).textTheme.display3,),
                              Text(item._earId,style: Theme.of(context).textTheme.display2,),
                              
                              // Icon(FontAwesomeIcons.sort,color: Colors.white,)
                            ],
                          )
                        )),
                        Flexible(flex: 2, child: Container(
                            // width: 10,
                            // decoration: BoxDecoration(
                            //   shape: BoxShape.circle,
                            //   color: Color(0xff369ee5)
                            // ),
                            // margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(15),
                            child: Image.asset("assets/images/state/${item._service}.png")
                            // Center(child: Baseline(baseline: 14, baselineType: TextBaseline.alphabetic, child: Text(item._state,style: Theme.of(context).textTheme.display1,),) ,) ,
                          )
                        ),
                        Flexible(flex: 2, child:Container(
                          width: double.infinity,
                          margin: EdgeInsets.all(0),
                          padding: EdgeInsets.only(top:20,bottom:20,left:10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(child:Text(""+item._service,style: Theme.of(context).textTheme.display3,)),
                              Center(child: Text(item._age,style:TextStyle(fontSize: 12)))
                              
                              // Icon(FontAwesomeIcons.sort,color: Colors.white,)
                            ],
                          )
                        )),
                      ],
                    ),
                    onTap: _onListItemClick,
                  ) 
                );
              },
              itemCount: _items.length,
            )
          )
      )
    );
  }

  _onListItemClick(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Detail())
    );
  }

  _buildSearchField(){
    return TextField(
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
        icon: const Icon(Icons.sentiment_very_satisfied),
        onPressed: _startSearch,
      ),
    ];
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