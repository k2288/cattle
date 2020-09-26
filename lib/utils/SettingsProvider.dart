class SettingsProvider{
  static final SettingsProvider _instance= SettingsProvider._internal();
  SettingsData _data;


  SettingsProvider._internal();

  factory SettingsProvider(){
    return _instance;
  }

  setSettings(SettingsData d){
    _data=d;
  }

  SettingsData getSettings(){
    return _data;
  }
  
}

class SettingsData{
  List<String> livestockState;
  List<String> livestockType;

  SettingsData({this.livestockState,this.livestockType});

  SettingsData.fromJSON(Map<String,dynamic> json)
    : livestockState=json["livestock_state"]!=null?(json["livestock_state"] as List).map((e) => e.toString()).toList():null,
      livestockType=json["livestock_type"]!=null?(json["livestock_type"] as List).map((e) => e.toString()).toList():null;
}