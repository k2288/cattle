import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainDashboardCard extends StatelessWidget {

  final Color _color;
  final String _count;
  final String _title;
  final String _image;

  MainDashboardCard(this._color,this._count,this._title,this._image);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: _color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(_count,style: Theme.of(context).textTheme.display1),
                Text(_title.toString(),style: Theme.of(context).textTheme.display1)
              ],
            ),
          ),
          Expanded(
            child:Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Flexible(
                  child: Container(),
                  flex: 2,
                ),
                Flexible(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 30, 0),
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(100),
                      )
                    ),
                    child: SvgPicture.asset(_image,fit:BoxFit.contain ,color: _color,),
                  ),
                )
              ],
            ),
          )

        ],
      ),
    );
  }
}