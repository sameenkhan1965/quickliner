import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/models/trips_history_model.dart';

class ScheduleRideProvider extends ChangeNotifier{
  List<TripsHistoryModel> scheduleRideList=[];
  bool wait=false;
  void getScheduleRide(context) {
    wait=true;
    scheduleRideList.clear();
    FirebaseDatabase.instance.ref().child("All Ride Requests").orderByChild("userName").equalTo(userModelCurrentInfo?.name).once().then((snap) {
      if (snap.snapshot.value != null) {
        Map keys = snap.snapshot.value as Map;
        keys.forEach((key, value) {
          if(value["status"]!="ended")
            {
          TripsHistoryModel scheduleRide = TripsHistoryModel.fromDynamic(value);
          scheduleRideList.add(scheduleRide);
          wait=false;
          notifyListeners();
            }
        });
      }
    });
  }
}