class DashboardData{
  int total;
  int dry;
  int calved;

  DashboardData({this.total});

  DashboardData.fromJSON(Map<String,dynamic> json)
    : total = json["total"],
      dry = json["dry"],
      calved = json["calved"];
}