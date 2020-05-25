import 'package:cattle/components/detail/detail.dart';
import 'package:cattle/components/list/td.dart';
import 'package:cattle/components/list/th.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class ListItem{
  final String _state;
  final String _earId;
  final String _gene;
  final String _age;
  ListItem(this._state,this._earId,this._gene,this._age);
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

  final List<ListItem> _items=List<ListItem>.generate(100,(i){
    return ListItem(faker.currency.code(),faker.guid.guid().substring(0,3),faker.person.firstName(),faker.date.year());
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
      body:Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top:10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(flex: 1, child: Th("وضعیت")),
                Flexible(flex: 1, child: Th("ش.گوش")),
                Flexible(flex: 1, child: Th("ژن")),
                Flexible(flex: 1, child: Th("سن")),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext buildContext,int index){
                ListItem item=_items[index];
                return Container(
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(flex: 1, child: Container(
                            // width: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff369ee5)
                            ),
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(10),
                            child: Center(child: Baseline(baseline: 14, baselineType: TextBaseline.alphabetic, child: Text(item._state,style: Theme.of(context).textTheme.display1,),) ,) ,
                          )
                        ),
                        Flexible(flex: 1, child: Td(item._earId)),
                        Flexible(flex: 1, child: Td(item._gene)),
                        Flexible(flex: 1, child: Td(item._age)),
                      ],
                    ),
                    onTap: _onListItemClick,
                  ) 
                );
              },
              itemCount: _items.length,
            )
          )
        ],
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