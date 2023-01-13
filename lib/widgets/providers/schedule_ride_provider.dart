import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/models/trips_history_model.dart';

class ScheduleRideProvider extends ChangeNotifier{
  List<TripsHistoryModel> scheduleRideList=[];
  bool wait=false;
  onValue(){
    return FirebaseDatabase.instance.ref().child("All Ride Requests").orderByChild("userName").equalTo(userModelCurrentInfo?.name).onValue;
  }

  Future<void> getScheduleRide(context) async {
    wait=true;
    scheduleRideList.clear();

    await FirebaseDatabase.instance.ref().child("All Ride Requests").orderByChild("userName").equalTo(userModelCurrentInfo?.name).onValue.listen ((eventSnap) {
      if (eventSnap.snapshot.value == null) {
        return;
      }
      (eventSnap.snapshot.value as Map).forEach((key, value) {
        final currentMessage = Map<String, dynamic>.from(value);
        print("i am in command ${currentMessage}");
        if(currentMessage['status']!="initiate"){
          print("in 1");
          if(currentMessage["rideType"]=="scheduleRide" && currentMessage["status"]!="ended" )
          {
            print("in 2");
            scheduleRideList.clear();
            TripsHistoryModel scheduleRide = TripsHistoryModel.fromDynamic(currentMessage);
            scheduleRide.key=key;
            scheduleRideList.add(scheduleRide);


            wait=false;
            notifyListeners();

          }
        }
        else{
          print("in else");
          scheduleRideList.clear();
        }


      });
      wait=false;
      notifyListeners();
      // eventSnap
    });
    wait=false;
    notifyListeners();


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