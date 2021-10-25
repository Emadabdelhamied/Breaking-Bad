class Character {
  int charId;
  String name;
  String birthday;
  List<dynamic> occupation;
  String image;
  String status;
  String nickname;
  List<dynamic> breakingBadAppearance;
  String portrayed;
  String category;
  List<dynamic> betterCallSaulAppearance;

  Character.fromJson(Map<String,dynamic>json){
    charId=json['char_id'];
    name=json['name'];
    birthday = json['birthday'];
    occupation=json['occupation'];
    image=json['img'];
    status=json['status'];
    nickname=json['nickname'];
    breakingBadAppearance=json['appearance'];
    portrayed=json['portrayed'];
    category=json['category'];
    betterCallSaulAppearance=json['better_call_saul_appearance'];
    
  }
}