
import 'package:cattle/models/User.dart';
import 'package:cattle/utils/api/ApiProvider.dart';
import 'package:cattle/utils/api/CustomException.dart';
import 'package:cattle/utils/api/Response.dart';

class UserRepository{
  ApiProvider _provider = ApiProvider();

  Future<Response> getMe()async{

    try{
      final response =await _provider.get("/v1/users/me");
      return Response.completed(User.fromJSON(response));
    }on FetchDataException catch(e){
      return Response.error(e.toString());
    }catch ( e){
      print(e);
      return null;
      
    }
  }
}