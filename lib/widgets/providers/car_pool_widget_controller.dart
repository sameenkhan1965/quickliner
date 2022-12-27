import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/models/trips_history_model.dart';
import 'package:users_app/models/user_model.dart';

class CarPoolWidgetController extends ChangeNotifier{
  List<TripsHistoryModel> rides=[];


  void getAllRides(context)
  {
    rides.clear();
    FirebaseDatabase.instance.ref()
        .child("All Ride Requests").orderByChild("status").equalTo("ontrip")
        .once()
        .then((snap)
    {
      if(snap.snapshot.value!=null)
      {
        Map keys=snap.snapshot.value as Map;
        print("snap.snapshot.value");
        print(snap.snapshot.value);
        keys.forEach((key, value) {
          TripsHistoryModel rideInfo = TripsHistoryModel.fromSnapshot(snap.snapshot);
        print("RIDE INFO ::::::::::::::::::");
        print(rideInfo.seats??"");
          rides.add(rideInfo);
          notifyListeners();
        });
      }

    });

  }
}