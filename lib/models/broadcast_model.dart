import 'package:firebase_database/firebase_database.dart';

class BroadcastData
{
  //attributes
  String? id;
  String? originAddress;
  String? destinationAddress1;
  String? destinationAddress2;
  String? noOfSeats;
  double? locationLatitude;
  double? locationLongitude;


  BroadcastData({
    this.id,
    this.originAddress,
    this.destinationAddress1,
    this.destinationAddress2,
    this.noOfSeats,
    this.locationLatitude,
    this.locationLongitude,
  });
  BroadcastData.fromSnapshot(dynamic snap)
  {
    originAddress = snap["originAddress"];
    destinationAddress1 = snap["destinationAddress1"];
    destinationAddress2 = snap["destinationAddress2"];
    noOfSeats = snap["noOfSeats"];
    id = snap["id"];

  }
}