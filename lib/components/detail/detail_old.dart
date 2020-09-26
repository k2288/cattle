import 'dart:math';

import 'package:cattle/components/dashboard/summary_card.dart';
import 'package:cattle/models/livestock.dart';
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

class Detail extends StatefulWidget {
  Livestock livestock;

  Detail({this.livestock});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {

  static List<String> service=["breeding","calved","onmilking","pragnent","weaned"];

  final List<ListItem> _items=List<ListItem>.generate(10,(i){
    DateTime date= faker.date.dateTime();
    return ListItem(faker.currency.code(),faker.guid.guid().substring(0,3),faker.person.firstName(),
    "1399/${date.month.toString().padLeft(2,"0")}/${date.day.toString().padLeft(2,"0")}",
    service[Random().nextInt(5)]);
  } );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("${widget.livestock.name} | ${widget.livestock.tagNo}"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: ()=>{},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: ()=>{},
          ),

        ],
      ),
      body: CustomScrollView(
        
        slivers: 
        <Widget>[
          SliverPadding(
              padding: EdgeInsets.only(
              left: 15.0,
              right: 15.0
            ),
            sliver:SliverList(
              delegate: SliverChildListDelegate([
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
                    SummaryCard(0,"تولد",555),
                    SummaryCard(1,"جنسیت",3),
                    SummaryCard(2,'مادر',5),
                    SummaryCard(3,'تلقیح کننده',1),
                    SummaryCard(4,"وزن",0),
                    SummaryCard(5,"تعداد شکم",2),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  itemCount: _items.length,
                  
                  itemBuilder: (BuildContext buildcontext,int index){
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
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(flex: 2, child: Container(
                            // width: 10,
                            padding: EdgeInsets.all(20),
                            child: Image.asset("assets/images/state/${item._service}.png")
                            // Center(child: Baseline(baseline: 14, baselineType: TextBaseline.alphabetic, child: Text(item._state,style: Theme.of(context).textTheme.display1,),) ,) ,
                          )
                        ),
                        Flexible(flex: 4, child:Container(
                          width: double.infinity,
                          margin: EdgeInsets.all(0),
                          // padding: EdgeInsets.only(top:20,bottom:20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(item._service,style: Theme.of(context).textTheme.display3,),
                              Text(item._gene,style: Theme.of(context).textTheme.display3,),
                              
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
                        Flexible(flex: 2, child:Container(
                          width: double.infinity,
                          margin: EdgeInsets.all(0),
                          padding: EdgeInsets.only(top:20,bottom:20,left:10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(child:Text(""+item._age,style: Theme.of(context).textTheme.display3,)),
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
              ]),
            ),
          )
 

        ],
      )
    );
  }
}