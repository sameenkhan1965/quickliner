import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:users_app/models/drivers_model.dart';
import 'package:users_app/models/trips_history_model.dart';
import 'package:users_app/widgets/ui/admin/Salary/salary.dart';

import '../../models/salary_model.dart';

class AllDriversProvider extends ChangeNotifier {
  List<TripsHistoryModel> broadCastRide = [];
  List<DriverData> allDrivers = [];

  void getAllDrivers(context) {
    // allDrivers.clear();
    FirebaseDatabase.instance.ref().child("drivers").
    once().then((snap) {
      if (snap.snapshot.value != null) {
        Map keys = snap.snapshot.value as Map;
        keys.forEach((key, value) {
          print("value");
          print(value);

          DriverData driverInfo = DriverData.fromSnapshot(value);
          print("driverInfo");
          print(driverInfo);
          allDrivers.add(driverInfo);
          notifyListeners();
        });
      }
    });
    print(allDrivers);
  }

  void getAllBroadCastRide(context) {
    broadCastRide.clear();
    FirebaseDatabase.instance
        .ref()
        .child("All Ride Requests")
        .orderByChild("rideType")
        .equalTo("broadCastRide")
        .once()
        .then((snap) {
      if (snap.snapshot.value != null) {
        Map keys = snap.snapshot.value as Map;
        keys.forEach((key, value) {
          print("value");
          print(value);

            TripsHistoryModel tripHistory =
                TripsHistoryModel.fromDynamic(value);
            print("tripHistory");
            print(tripHistory);
            broadCastRide.add(tripHistory);
            notifyListeners();
        });
      }
      // var tripHistory = DriverData.fromSnapshot(snap.snapshot);
      // allDrivers.add(tripHistory);
      // if((snap.snapshot.value as Map)["status"] == "ended")
      // {
      //   //update-add each history to OverAllTrips History Data List
      //   Provider.of<AppInfo>(context, listen: false).updateOverAllTripsHistoryInformation(allDrivers);
      // }
    });
    print(broadCastRide);
  }

  List<DriverSalary> allDriversSalart = [];

  // void getAllDrivers(context) {
  //   // allDrivers.clear();
  //   FirebaseDatabase.instance.ref().child("drivers").
  //   once().then((snap) {
  //     if (snap.snapshot.value != null) {
  //       Map keys = snap.snapshot.value as Map;
  //       keys.forEach((key, value) {
  //         print("value");
  //         print(value);

  //         DriverData driverInfo = DriverData.fromSnapshot(value);
  //         print("driverInfo");
  //         print(driverInfo);
  //         allDrivers.add(driverInfo);
  //         notifyListeners();
  //       });
  //     }
  //   });
  //   print(allDrivers);
  // }

}
