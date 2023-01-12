import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:users_app/models/broadcast_model.dart';

class BroadcastRequestProvider extends ChangeNotifier{
  List<BroadcastData> allBroadcasts=[];

  void getAllBroadcastRequests(context)
  {
    allBroadcasts.clear();
    FirebaseDatabase.instance.ref()
        .child("Broadcast Rides")
        .once()
        .then((snap)
    {
      if(snap.snapshot.value!=null)
        {
          Map keys=snap.snapshot.value as Map;
          keys.forEach((key, value) {
            print("value");
            print(value);

            BroadcastData broadcastInfo = BroadcastData.fromSnapshot(value);
            print("broadcast");
            print(broadcastInfo);
            allBroadcasts.add(broadcastInfo);
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
  print(allBroadcasts);
  }
}