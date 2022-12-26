
import 'package:flutter/material.dart';
import 'package:users_app/widgets/providers/admin/all_customer_provider.dart';
import 'package:users_app/widgets/providers/all_drivers_provider.dart';

class AdminDashBoardProvider extends ChangeNotifier{
  List<String> dashboardList=[];
  List<MaterialColor> dashboardContainerColor=[
    Colors.blue,
    Colors.red,
    Colors.brown,
  ];
  List<dynamic> dashboardContainerProvider=[
    AllDriversProvider(),
    AllCustomersProviders(),
    AllCustomersProviders(),
  ];


  getDashboardList()
  {
    dashboardList.clear();
    dashboardList.add("All Drivers");
    dashboardList.add("All Customers");
    dashboardList.add("All Rides");
  }

}