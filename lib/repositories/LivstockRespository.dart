import 'dart:convert';

import 'package:cattle/models/LivestockState.dart';
import 'package:cattle/models/livestock.dart';
import 'package:cattle/utils/api/ApiProvider.dart';
import 'package:cattle/utils/api/Response.dart';

class LivestockRepository{
  ApiProvider _apiProvider= ApiProvider();

  Future<Response> postLivestock(body)async{
    try{
      final response= await _apiProvider.post("/v1/livestock",body);
      return Response.completed(Livestock.fromJSON(response));

    }catch (e){
      return Response.error(e.toString());
    }
  }

  Future<Response> putLivestock(id,body)async{
    try{
      final response= await _apiProvider.put("/v1/livestock/$id",body);
      return Response.completed(Livestock.fromJSON(jsonDecode( body)));

    }catch (e){
      return Response.error(e.toString());
    }
  }

  Future<Response> getLivestockList(params)async{
    try{
      final response=await _apiProvider.get("/v1/livestock",params);
      return Response.completed(LiveStockResponse.fromJSON(response));
    }catch(e){
      return Response.error(e.toString());
    }
  }

  Future<Response> deleteLivestock(id)async{
    try{
      final response = await _apiProvider.delete("/v1/livestock/$id");
      return Response.completed(Livestock.fromJSON(response));
    }catch(e){
      return Response.error(e.toString());
    }
  }

  Future<Response> postState(id,body)async{
    try{
      final response = await _apiProvider.post("/v1/livestock/$id/state",jsonEncode(body));
      return Response.completed(LivestockState.fromJSON(response));
    }catch(e){
      return Response.error(e.toString());
    }
  }

  Future<Response> putState(id,body)async{
    try{
      final response = await _apiProvider.put("/v1/livestock/$id/state/${body['id']}",jsonEncode(body));
      return Response.completed(response);
    }catch(e){
      return Response.error(e.toString());
    }
  }

  Future<Response> getStates(id,params)async{
    try{
      final response = await _apiProvider.get("/v1/livestock/$id/state",params);
      return Response.completed( LiveStockStateResponse.fromJSON(response));
    }catch(e){
      return Response.error(e.toString());
    }
  }

  Future<Response> deleteLivestockState(id,stateId)async{
    try{
      final response = await _apiProvider.delete("/v1/livestock/$id/state/$stateId");
      return Response.completed(Livestock.fromJSON(response));
    }catch(e){
      return Response.error(e.toString());
    }
  }



}

class LiveStockResponse{
  List<Livestock> content;
  int totalElements;
  int offset;
  int pageSize;

  LiveStockResponse({this.content});

  LiveStockResponse.fromJSON(Map<String,dynamic> json)
    : content=json["content"]!=null?(json["content"] as List).map((e) => Livestock.fromJSON(e)).toList():[],
      totalElements=json["totalElements"],
      offset=json["offset"],
      pageSize=json["pageSize"];
}

class LiveStockStateResponse{
  List<LivestockState> content;
  int totalElements;
  int offset;
  int pageSize;

  LiveStockStateResponse({this.content});

  LiveStockStateResponse.fromJSON(Map<String,dynamic> json)
    : content=json["content"]!=null?(json["content"] as List).map((e) => LivestockState.fromJSON(e)).toList():[],
      totalElements=json["totalElements"],
      offset=json["offset"],
      pageSize=json["pageSize"];
}