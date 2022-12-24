import 'package:flutter/cupertino.dart';
import 'package:users_app/models/transport_category_model.dart';

class TransportCategoryProvider extends ChangeNotifier{
  List<TransportCategoryModel> allCategories=[];
 void getAllTransport()
 {
   allCategories.clear();
   allCategories.addAll([
     TransportCategoryModel(transportImage: 'images/solo.png', transportName: 'Solo\n Ride'),
     TransportCategoryModel(transportImage: 'images/instant.png', transportName: 'Generate\nRequest'),
     TransportCategoryModel(transportImage:  'images/longterm.png', transportName: 'Permanent\nRide'),
     TransportCategoryModel(transportImage: 'images/broadcast.png', transportName: 'View\n  Broadcasts'),
     TransportCategoryModel(transportImage: 'images/schedule.png', transportName: 'Schedule\nRide'),
   ]);
   notifyListeners();
 }
}

