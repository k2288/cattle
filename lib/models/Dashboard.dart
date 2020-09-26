class DashboardData{
  int total;

  DashboardData({this.total});

  DashboardData.fromJSON(Map<String,dynamic> json)
    : total = json["total"];
}