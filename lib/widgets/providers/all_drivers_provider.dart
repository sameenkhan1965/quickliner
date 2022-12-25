import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:users_app/models/drivers_model.dart';

class AllDriversProvider extends ChangeNotifier{
  List<DriverData> allDrivers=[];

  void getAllDrivers(context)
  {
    allDrivers.clear();
    FirebaseDatabase.instance.ref()
        .child("drivers")
        .once()
        .then((snap)
    {
      if(snap.snapshot.value!=null)
        {
          Map keys=snap.snapshot.value as Map;
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
      // var driverInfo = DriverData.fromSnapshot(snap.snapshot);
      // allDrivers.add(driverInfo);
      // if((snap.snapshot.value as Map)["status"] == "ended")
      // {
      //   //update-add each history to OverAllTrips History Data List
      //   Provider.of<AppInfo>(context, listen: false).updateOverAllTripsHistoryInformation(allDrivers);
      // }
    });
  print(allDrivers);
  }
}