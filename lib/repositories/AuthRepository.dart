import 'package:cattle/models/LoginResponse.dart';
import 'package:cattle/utils/api/ApiProvider.dart';
import 'package:cattle/utils/api/Response.dart';

class AuthRepository{
  ApiProvider _apiProvider=ApiProvider();

  Future<Response> login(body)async{
    try{
      final response = await _apiProvider.post("/v1/auth",body);
      return Response.completed( LoginResponse.fromJSON(response));
    }catch (e){
      return Response.error(e.toString());
    }
  }
}