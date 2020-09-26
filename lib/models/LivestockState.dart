class LivestockState{
  String state;
  String date;
  String description;

  LivestockState.fromJSON(Map<String,dynamic> json)
    : state=json["state"],
      date=json["date"],
      description=json["description"];
}