import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:users_app/models/drivers_model.dart';
import 'package:users_app/models/user_model.dart';

class AllCustomersProviders extends ChangeNotifier{
  List<UserModel> allCustomers=[];

  void getAllCustomers(context)
  {
    allCustomers.clear();
    FirebaseDatabase.instance.ref()
        .child("users")
        .once()
        .then((snap)
    {
      if(snap.snapshot.value!=null)
      {
        Map keys=snap.snapshot.value as Map;
        keys.forEach((key, value) {
          print("value");
          print(value);

          UserModel userModel = UserModel.fromSnapshot(snap.snapshot);
          print("userINfo");
          print(userModel);
          allCustomers.add(userModel);
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
    print(allCustomers);
  }
}