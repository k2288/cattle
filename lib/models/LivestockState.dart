
class LivestockState{
  String id;
  String state;
  String date;
  String description;

  LivestockState(this.state,this.date,this.description,[this.id]);

  LivestockState.fromJSON(Map<String,dynamic> json)
    : state=json["state"],
      id=json["_id"],
      date=json["date"]!=null?json["date"]:"",
      description=json["description"];
}