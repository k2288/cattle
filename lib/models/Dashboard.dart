class DashboardData {
  int total;
  int dry;
  int calved;
  int insemination;
  int milked;
  int heifer;
  int abortion;
  int bull;
  int cow;

  DashboardData({
    this.total = 0,
    this.dry = 0,
    this.calved = 0,
    this.insemination = 0,
    this.milked = 0,
    this.heifer = 0,
    this.abortion = 0,
    this.bull = 0,
    this.cow = 0,
  });

  DashboardData.fromJSON(Map<String, dynamic> json)
      : total = json["total"] ?? 0,
        dry = json["dry"] ?? 0,
        calved = json["calved"] ?? 0,
        insemination = json["insemination"] ?? 0,
        milked = json["milked"] ?? 0,
        heifer = json["heifer"] ?? 0,
        abortion = json["abortion"] ?? 0,
        bull = json["bull"] ?? 0,
        cow = json["cow"] ?? 0;
}
