class LoginResponse{
  String token;

  LoginResponse({this.token});

  LoginResponse.fromJSON(Map<String,dynamic> json)
    : token=json["token"];
}