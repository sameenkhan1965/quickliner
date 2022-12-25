import 'package:flutter/cupertino.dart';

class AdminDashBoardProvider extends ChangeNotifier{
  List<String> dashboardList=[];


  getDashboardList()
  {
    dashboardList.clear();
    dashboardList.add("All Drivers");
    dashboardList.add("All Customers");
    dashboardList.add("All Rides");
  }
}