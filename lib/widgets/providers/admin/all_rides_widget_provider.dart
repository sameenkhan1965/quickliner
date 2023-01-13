import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:users_app/models/trips_history_model.dart';

class AllRidesWigetProvider extends ChangeNotifier{
  List<TripsHistoryModel> allRides=[];
  List<String> tabBar=[
    "All",
    "Solo Ride",
    "Car Pool",
    "Permanent Request",
    "Schedule",
    "Broad Cast"
  ];

  void getAllRides(context)
  {
  List<TripsHistoryModel> list=[];
    // allRides.clear();
    FirebaseDatabase.instance.ref()
        .child("All Ride Requests")
        .once()
        .then((snap)
    {
      if(snap.snapshot.value!=null)
      {
        Map keys=snap.snapshot.value as Map;

        keys.forEach((key, value) {
          print("value");
          TripsHistoryModel tripsHistoryModel = TripsHistoryModel.fromDynamic(value);
          print("tipHistoryModel");
          print(tripsHistoryModel.destination);
          list.add(tripsHistoryModel);
          notifyListeners();
        });
      }
    });
    allRides=list;
    notifyListeners();
  }
}

