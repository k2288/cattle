class Livestock{
  String id;
  String tagNo;
  String name;
  String birthDate;
  String lastStateDate;
  String gender;
  String mother;
  String inseminator;
  String state;
  String userId;

  Livestock({this.tagNo,this.name,this.birthDate,this.gender,this.mother,this.inseminator,this.state,this.userId});

  Livestock.fromJSON(Map<String,dynamic> json)
    : tagNo=json["tagNo"],
      id=json["_id"],
      name=json["name"],
      birthDate=json["birthDate"],
      lastStateDate=json["lastStateDate"],
      gender=json["gender"],
      mother=json["mother"],
      inseminator=json["inseminator"],
      state=json["state"],
      userId=json["user_id"];
}
