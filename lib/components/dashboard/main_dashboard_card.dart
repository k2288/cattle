import 'package:cattle/models/LocaleModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class MainDashboardCard extends StatelessWidget {

  final Color _color;
  final String _count;
  final String _title;
  final String _image;
  final Function _onTab;

  MainDashboardCard(this._color,this._count,this._title,this._image,this._onTab);

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAlias,
        color: _color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: InkWell(
          onTap: _onTab,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(_count=="null"?"":_count,style: Theme.of(context).textTheme.headline4),
                    Text(_title.toString(),style: Theme.of(context).textTheme.headline4)
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
                        padding: EdgeInsets.fromLTRB(
                          Language.isRtl(context) ?10:30, 10,Language.isRtl(context)?30: 10, 0
                        ),
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Language.isRtl(context)?Radius.zero : Radius.circular(100),
                            topRight: Language.isRtl(context)? Radius.circular(100):Radius.zero,
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
        )
    );
  }
}