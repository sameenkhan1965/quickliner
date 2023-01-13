import 'package:firebase_database/firebase_database.dart';

class DriverData {
  //attributes
  String? id;
  String? name;
  String? phone;
  String? email;
  String? car_color;
  String? car_model;
  String? car_number;
  String? car_type;
  String? Earning;

  DriverData(
      {this.id,
      this.name,
      this.phone,
      this.email,
      this.car_color,
      this.car_model,
      this.car_number,
      this.car_type,
      this.Earning});
  DriverData.fromSnapshot(dynamic snap) {
    phone = snap["phone"];
    name = snap["name"];
    id = snap["id"];
    email = snap["email"];
    car_color = snap["car_details"]["car_color"];
    car_model = snap["car_details"]["car_model"];
    car_number = snap["car_details"]["car_number"];
    car_type = snap["car_details"]["type"];
    Earning = snap["earnings"];
  }
}
