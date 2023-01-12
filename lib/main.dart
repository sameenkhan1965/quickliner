import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/infoHandler/app_info.dart';
import 'package:users_app/splashScreen/splash_screen.dart';
import 'package:users_app/splashScreen/splash_screen3.dart';
import 'package:users_app/widgets/providers/admin/admin_dashboard_provider.dart';
import 'package:users_app/widgets/providers/admin/all_customer_provider.dart';
import 'package:users_app/widgets/providers/admin/all_rides_widget_provider.dart';
import 'package:users_app/widgets/providers/all_drivers_provider.dart';
import 'package:users_app/widgets/providers/broadcast_requests_provider.dart';
import 'package:users_app/widgets/providers/car_pool_widget_controller.dart';
import 'package:users_app/widgets/providers/category_transport_provider.dart';
import 'package:users_app/widgets/providers/schedule_ride_provider.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MyApp(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<TransportCategoryProvider>(create: (_)=>TransportCategoryProvider()),
          ChangeNotifierProvider<AppInfo>(create: (_)=>AppInfo()),
          ChangeNotifierProvider<AllDriversProvider>(create: (_)=>AllDriversProvider()),
          ChangeNotifierProvider<BroadcastRequestProvider>(create: (_)=>BroadcastRequestProvider()),
          ChangeNotifierProvider<AdminDashBoardProvider>(create: (_)=>AdminDashBoardProvider()),
          ChangeNotifierProvider<AllCustomersProviders>(create: (_)=>AllCustomersProviders()),
          ChangeNotifierProvider<CarPoolWidgetController>(create: (_)=>CarPoolWidgetController()),
          ChangeNotifierProvider<AllRidesWigetProvider>(create: (_)=>AllRidesWigetProvider()),
          ChangeNotifierProvider<ScheduleRideProvider>(create: (_)=>ScheduleRideProvider()),
        ],
        child:MaterialApp(
                title: 'Drivers App',
                theme: ThemeData(
                  primarySwatch: Colors.teal,
                ),

              home: MySplashScreen(userType: userModelCurrentInfo?.userType??"",),
                debugShowCheckedModeBanner: false,
              ),
      ),
    ),
    // MyApp(
    //   child: ChangeNotifierProvider(
    //     create: (context) => AppInfo(),
    //     child: MaterialApp(
    //       title: 'Drivers App',
    //       theme: ThemeData(
    //         primarySwatch: Colors.blue,
    //       ),
    //       home: MySplashScreen(userType: "",),
    //       debugShowCheckedModeBanner: false,
    //     ),
    //   ),
    // ),
  );


}



class MyApp extends StatefulWidget
{
  final Widget? child;

  MyApp({this.child});

  static void restartApp(BuildContext context)
  {
    context.findAncestorStateOfType<_MyAppState>()!.restartApp();
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
{
  Key key = UniqueKey();

  void restartApp()
  {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child!,
    );
  }
}



