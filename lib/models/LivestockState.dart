import 'package:persian_date/persian_date.dart';

class LivestockState{
  String id;
  String state;
  String date;
  String description;

  LivestockState(this.state,this.date,this.description,[this.id]);

  LivestockState.fromJSON(Map<String,dynamic> json)
    : state=json["state"],
      id=json["_id"],
      date=json["date"]!=null?PersianDate().gregorianToJalali(json["date"],"yyyy/mm/d"):"",
      description=json["description"];
}