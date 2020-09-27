class DashboardData{
  int total;
  int dry;
  int calved;
  int insemination;
  int milked;
  int heifer;
  int abortion;
  int bull;
  int cow;

  DashboardData({this.total});

  DashboardData.fromJSON(Map<String,dynamic> json)
    : total = json["total"],
      dry = json["dry"],
      calved = json["calved"],
      insemination = json["insemination"],
      milked = json["milked"],
      heifer = json["heifer"],
      abortion = json["abortion"],
      bull = json["bull"],
      cow = json["cow"]
      ;
}