import "package:flutter/material.dart";

class SummaryCard extends StatelessWidget {

  final int _index;
  final String _title;
  final dynamic _count;
  final Function _onTab;
  SummaryCard(this._index,this._title,this._count,this._onTab);

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: _index==2?Radius.circular(10): Radius.circular(0),
          topRight: _index==0?Radius.circular(10): Radius.circular(0),
          bottomLeft: _index==5?Radius.circular(10): Radius.circular(0),
          bottomRight: _index==3?Radius.circular(10): Radius.circular(0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200],
            blurRadius: 1,
            spreadRadius: .5,
            offset: Offset(
              -2,
              1
            )
          )
        ]
      ),
      child:InkWell(
        onTap: _onTab,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Flexible(
              child:Container(
                padding: EdgeInsets.only(
                  left: 11,
                  right: 11,
                  top: 7,
                  bottom: 4
                ),
                margin: EdgeInsets.only(
                  top:10,
                  bottom: 5
                ),
                decoration: BoxDecoration(
                  color: Color(0xff39445a),
                  borderRadius: BorderRadius.circular(90)
                ),
                child: Text(_count.toString(),style: TextStyle(color: Colors.white),),
              ),
              flex: 2,
            ),
            Flexible(
              child: Container(
                child: Center(child: Text(_title,style: Theme.of(context).textTheme.subtitle,)) ,
              ),
              flex: 1,
            )
          ],
        ),
      )
      
    );
  }
}