import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/infoHandler/app_info.dart';
import 'package:users_app/splashScreen/splash_screen.dart';
import 'package:users_app/widgets/providers/admin/admin_dashboard_provider.dart';
import 'package:users_app/widgets/providers/admin/all_customer_provider.dart';
import 'package:users_app/widgets/providers/all_drivers_provider.dart';
import 'package:users_app/widgets/providers/category_transport_provider.dart';

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
          ChangeNotifierProvider<AdminDashBoardProvider>(create: (_)=>AdminDashBoardProvider()),
          ChangeNotifierProvider<AllCustomersProviders>(create: (_)=>AllCustomersProviders()),
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



