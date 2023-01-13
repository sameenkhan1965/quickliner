import 'package:firebase_database/firebase_database.dart';

class UserModel
{
  String? phone;
  String? name;
  String? id;
  String? email;
  String? userType;

  UserModel({this.phone, this.name, this.id, this.email,this.userType});

  UserModel.fromSnapshot(dynamic snap)
  {
    phone = snap["phone"];
    name = snap["name"];
    id = snap["id"];
    email = snap["email"];
    userType = snap["userType"];
  }

  
}