import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/models/trips_history_model.dart';

class PermanentRideProvider extends ChangeNotifier{
  List<TripsHistoryModel> PermanentRideList=[];
  bool wait=false;
  onValue(){
    return FirebaseDatabase.instance.ref().child("All Ride Requests").orderByChild("userName").equalTo(userModelCurrentInfo?.name).onValue;
  }

  void getScheduleRide(context) {
    wait=true;
    PermanentRideList.clear();

    FirebaseDatabase.instance.ref().child("All Ride Requests").orderByChild("userName").equalTo(userModelCurrentInfo?.name).onValue.listen ((eventSnap) {
      if (eventSnap.snapshot.value == null) {
        return;
      }
      (eventSnap.snapshot.value as Map).forEach((key, value) {
        final currentMessage = Map<String, dynamic>.from(value);
        if(currentMessage["rideType"]=="permanentRide" && currentMessage["status"]!="ended")
        {
          PermanentRideList.clear();
          TripsHistoryModel scheduleRide = TripsHistoryModel.fromDynamic(currentMessage);
          scheduleRide.key=key;

          PermanentRideList.add(scheduleRide);

          wait=false;
          notifyListeners();

        }

      });
      wait=false;
      notifyListeners();
      // eventSnap
    });


    // .then((snap) {
    // print("snapp-->> ${snap.snapshot.value}");
    // snap.value. entries
    // print("snap value --->> ${snap.value}");
    // final myMessages = Map<dynamic, dynamic>.from(
    //     (snap.data! as DatabaseEvent).snapshot.value
    //     as Map<dynamic, dynamic>); //typecasting
    // lists=[];
    // myMessages.forEach((key, value) {
    //   final currentMessage = Map<String, dynamic>.from(value);
    //   lists.add([key,currentMessage]);
    // });
    // if (snap.snapshot.value != null) {
    //
    //   Map keys = snap.snapshot.value as Map;
    //   keys.forEach((key, value) {
    //     if(value["status"]!="ended")
    //       {
    //
    //     TripsHistoryModel scheduleRide = TripsHistoryModel.fromDynamic(value);
    //     scheduleRideList.add(scheduleRide);
    //     wait=false;
    //     notifyListeners();
    //       }
    //
    //   });
    //   wait=false;
    //   notifyListeners();
    // }
    // else{
    //   wait=false;
    //   notifyListeners();
    // }
    // }).catchError((e){
    //   wait=false;
    //   notifyListeners();
    // });
  }
}