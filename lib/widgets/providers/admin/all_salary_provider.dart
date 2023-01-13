// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:users_app/models/salary_model.dart';
// import 'package:users_app/models/trips_history_model.dart';

// class AllRidesWigetProvider extends ChangeNotifier{
//   List<DriverSalary> allRides=[];
//   // List<String> tabBar=[
//   //   "All",
//   //   "Solo Ride",
//   //   "Car Pool",
//   //   "Permanent Request",
//   // ];

//   void getDriverSalary(context)
//   {
//   List<DriverSalary> list=[];
//     // allRides.clear();
//     FirebaseDatabase.instance.ref()
//         .child("All Ride Requests")
//         .once()
//         .then((snap)
//     {
//       if(snap.snapshot.value!=null)
//       {
//         Map keys=snap.snapshot.value as Map;

//         keys.forEach((key, value) {
//           print("value");
//           DriverSalary driverSalary = driverSalary.earning(value);
//           print("tipHistoryModel");
//           print(driverSalary.destination);
//           list.add(driverSalary);
//           notifyListeners();
//         });
//       }
//     });
//     allRides=list;
//     notifyListeners();
//   }
// }