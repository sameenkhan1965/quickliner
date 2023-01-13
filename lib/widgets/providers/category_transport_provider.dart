import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:users_app/mainScreens/request_screen.dart';
import 'package:users_app/models/transport_category_model.dart';
import 'package:users_app/widgets/ui/customer/car_pool/car_pool_widget.dart';
import 'package:users_app/widgets/ui/customer/schedule_ride/schedule_ride.dart';

import '../ui/customer/permanant_ride/permanent_main.dart';
import '../ui/customer/permanant_ride/permanent_ride.dart';

class TransportCategoryProvider extends ChangeNotifier{
  List<TransportCategoryModel> allCategories=[];
 void getAllTransport()
 {
   allCategories.clear();
   allCategories.addAll([
     TransportCategoryModel(transportImage: 'images/solo.png', transportName: 'Car Pool',route: CarPoolWidget()),
     TransportCategoryModel(transportImage: 'images/instant.png', transportName: 'Solo Ride',route:  RequestScreen()),
     TransportCategoryModel(transportImage:  'images/longterm.png', transportName: 'Permanent\nRide',route: PermanentRideMain()),
     TransportCategoryModel(transportImage: 'images/broadcast.png', transportName: 'View\nBroadcasts',route: CarPoolWidget()),
     TransportCategoryModel(transportImage: 'images/schedule.png', transportName: 'Schedule\nRide',route: ScheduleRide()),
   ]);
 }
}

