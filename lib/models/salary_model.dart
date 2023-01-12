import 'package:firebase_database/firebase_database.dart';

class DriverSalary
{
  //attributes
  String? id;
  String? name;
  String? phone;
  String? email;
  String? earning;
  String? percentage;
  String? salary;


  DriverSalary({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.earning,
    this.percentage,
    this.salary,
    
  });
  DriverSalary.fromSnapshot(dynamic snap)
  {
    phone = snap["phone"];
    name = snap["name"];
    id = snap["id"];
    email = snap["email"];
    earning = snap["earning"]["earning"];
    percentage = snap["earning"]["earning"];
    salary = snap["earning"]["earning"];
    

  }
}