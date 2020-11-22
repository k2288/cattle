
import 'package:cattle/models/LoginResponse.dart';
import 'package:cattle/utils/api/ApiProvider.dart';
import 'package:cattle/utils/api/Response.dart';

class AuthRepository{
  ApiProvider _apiProvider=ApiProvider();

  Future<Response> postUser(body)async{
    try{
      final response = await _apiProvider.post("/v1/auth/phone",body);
      return Response.completed( response);
    }catch (e){
      return Response.error(e.toString());
    }
  }

  Future<Response> postCode(body)async{
    try{
      final response = await _apiProvider.post("/v1/auth/code",body);
      print(response.runtimeType);
      return Response.completed( LoginResponse.fromJSON( response));
    }catch (e){
      return Response.error(e.toString());
    }
  }
}