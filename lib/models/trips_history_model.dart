import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TripsHistoryModel
{
  String? time;
  String? originAddress;
  String? destinationAddress;
  String? status;
  String? fareAmount;
  String? car_details;
  String? driverName;
  dynamic? origin;
  dynamic? destination;

  String? seats;
  String? rideType;

  TripsHistoryModel({
    this.time,
    this.originAddress,
    this.destinationAddress,
    this.status,
    this.car_details,
    this.driverName,
    this.seats,
    this.rideType,
    required this.origin,
    required this.destination,
  });

  TripsHistoryModel.fromSnapshot(DataSnapshot dataSnapshot)
  {
    print("dataSnapshot");
    print(dataSnapshot.value);
    time = (dataSnapshot.value as Map)["time"];
    originAddress = (dataSnapshot.value as Map)["originAddress"];
    destinationAddress = (dataSnapshot.value as Map)["destinationAddress"];
    status = (dataSnapshot.value as Map)["status"];
    fareAmount = (dataSnapshot.value as Map)["fareAmount"];
    car_details = (dataSnapshot.value as Map)["car_details"];
    driverName = (dataSnapshot.value as Map)["driverName"];
    rideType = (dataSnapshot.value as Map)["rideType"];
    seats = (dataSnapshot.value as Map)["noOfSeats"];
  }

  TripsHistoryModel.fromDynamic(dynamic dataSnapshot)
  {
    print("Des");
    print(dataSnapshot["destination"]);
    time = dataSnapshot["time"];
    originAddress = dataSnapshot["originAddress"];
    destinationAddress = dataSnapshot["destinationAddress"];
    status = dataSnapshot["status"];
    fareAmount = dataSnapshot["fareAmount"];
    car_details = dataSnapshot["car_details"];
    driverName = dataSnapshot["driverName"];
    rideType = dataSnapshot["rideType"];
    seats = dataSnapshot["noOfSeats"];
    destination= dataSnapshot["destination"];
    origin= dataSnapshot["origin"];
  }
}