
class UserModel {
  String? name;
  String? email;
  String? uId;
  String? cover;
  String? bio;
  String? image;
  String?password;
  // MessageModel? lastMessage; // Add this line

  UserModel({
    this.name,
    this.email,
    this.uId,
    this.cover,
    this.bio,
    this.image,
    // this.lastMessage
    this.password
  });

  UserModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    email=json['email'];
    uId=json['uId'];
    cover=json['cover'];
    bio=json['bio'];
    image=json['image'];
    password=json['password'];
  }

  Map<String,dynamic>toMap(){
    return{
      'name':name,
      'email':email,
      'uId':uId,
      'cover':cover,
      'bio':bio,
      'image':image,
      'password':password,
    };
  }
}