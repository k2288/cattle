import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailCardAction extends StatelessWidget {

  final Color _color;
  final Color _imageColor;
  final Function _onTab;
  final String _image;
  final String _title;

  DetailCardAction(this._color,this._onTab,this._title,this._image,this._imageColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      child:Card(
        clipBehavior: Clip.antiAlias,
        color: _color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: InkWell(
          onTap: _onTab,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: Container(
                    height: 60,
                    width: 60,
                    // color: Colors.black,
                    child: SvgPicture.asset(_image ,color: _imageColor,fit: BoxFit.cover,),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Text(_title,style: TextStyle(color: _imageColor,fontSize: 15,fontWeight:FontWeight.bold)),
                )
              ],
            ),
          )
        ),
      ) ,
    );
  }
}