import 'package:cattle/models/Dashboard.dart';
import 'package:cattle/utils/api/ApiProvider.dart';
import 'package:cattle/utils/api/Response.dart';

class DashboardRespository{
  ApiProvider _apiProvider=ApiProvider();

  Future<Response> getDashboard()async{
    try{
      final response= await _apiProvider.get("/v1/dashboard");
      return Response.completed(DashboardData.fromJSON(response));
    }catch (e){
      return Response.error(e.toString());
    }
    
  }
}