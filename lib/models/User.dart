class User{
  String phone;

  User({this.phone});

  User.fromJSON(Map<String,dynamic> json)
    : phone=json["phone"];
}