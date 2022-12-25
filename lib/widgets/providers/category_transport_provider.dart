import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:users_app/models/transport_category_model.dart';
import 'package:users_app/widgets/ui/customer/car_pool/car_pool_widget.dart';

class TransportCategoryProvider extends ChangeNotifier{
  List<TransportCategoryModel> allCategories=[];
 void getAllTransport()
 {
   allCategories.clear();
   allCategories.addAll([
     TransportCategoryModel(transportImage: 'images/solo.png', transportName: 'Car \n Pool',route: MaterialPageRoute(
         builder: (context) => CarPoolWidget())),
     TransportCategoryModel(transportImage: 'images/instant.png', transportName: 'Generate\nRequest',route: MaterialPageRoute(
         builder: (context) => CarPoolWidget())),
     TransportCategoryModel(transportImage:  'images/longterm.png', transportName: 'Permanent\nRide',route: MaterialPageRoute(
         builder: (context) => CarPoolWidget())),
     TransportCategoryModel(transportImage: 'images/broadcast.png', transportName: 'View\n  Broadcasts',route: MaterialPageRoute(
         builder: (context) => CarPoolWidget())),
     TransportCategoryModel(transportImage: 'images/schedule.png', transportName: 'Schedule\nRide',route: MaterialPageRoute(
         builder: (context) => CarPoolWidget())),
   ]);
 }
}

