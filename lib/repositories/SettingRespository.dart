import 'package:cattle/utils/SettingsProvider.dart';
import 'package:cattle/utils/api/ApiProvider.dart';
import 'package:cattle/utils/api/Response.dart';

class SettingRepository{
  ApiProvider _apiProvider=ApiProvider();

  Future<Response> get()async{
    try{
      var response= await _apiProvider.get("/v1/settings");
      return Response.completed(SettingsData.fromJSON(response));
    }catch(e){
      return Response.error(e.toString());
    }
  }
}