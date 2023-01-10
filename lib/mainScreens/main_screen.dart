import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:users_app/assistants/assistant_methods.dart';
import 'package:users_app/authentication/login_screen.dart';
import 'package:users_app/global/colors.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/mainScreens/request_screen.dart';
import 'package:users_app/widgets/my_drawer.dart';
import 'package:users_app/configuraton/configuration.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:users_app/widgets/providers/all_drivers_provider.dart';
import 'package:users_app/widgets/providers/category_transport_provider.dart';
import 'package:users_app/widgets/ui/customer/car_pool/car_pool_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<ScaffoldState> sKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Provider.of<TransportCategoryProvider>(context, listen: false)
        .getAllTransport();
    Provider.of<AllDriversProvider>(context, listen: false)
        .getAllBroadCastRide(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: sKey,
      drawer: SizedBox(
        width: 265,
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.black,
          ),
          child: MyDrawer(
            name: userModelCurrentInfo!.name,
            email: userModelCurrentInfo!.email,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //custom hamburger button for drawer
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      sKey.currentState!.openDrawer();
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.menu,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      const Text('Location'),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: primaryGreen,
                          ),
                          const Text('Islamabad, Pakistan'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 100,
                child: Consumer<TransportCategoryProvider>(
                  builder: (context, value, child) => ListView.builder(
                      shrinkWrap: true,
                      itemCount: categories.length,
                      scrollDirection: Axis.horizontal,

                      itemBuilder: (context, index) {
                        return getCategoriesContainer(
                            value.allCategories[index].transportName,
                            value.allCategories[index].route);
                      }),
                ),
              ),

              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.greenAccent[30],
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text(
                      'Available Drivers',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        //boxShadow: shadowList,
                        borderRadius: BorderRadius.circular(10)),
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>AvailableDrivers()));
                      },
                      child: Text(
                        "View all Broadcasts",
                        style: TextStyle(
                            color: primaryGreen, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: getHeight(context)*0.65,
                child: Consumer<AllDriversProvider>(
                  builder: (context, value, child) => SingleChildScrollView(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.broadCastRide.length,
                        physics: const ScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        itemBuilder: (context, index) {
                          // return Text(value.broadCastRide[index].originAddress??"");
                          return getDriverRow(
                              name: value.broadCastRide[index].driverName ?? "",
                              carNo: value.broadCastRide[index].rideType ?? "",
                              carColor: value.broadCastRide[index].rideType ?? "",
                              carName: value.broadCastRide[index].destinationAddress ?? "",
                              carType: value.broadCastRide[index].car_details ??
                                  "quick-van");
                        }),
                  ),
                ),
              ),

              //***************** Braodcasts *********************************

              //
              // Container(
              //   margin: const EdgeInsets.only(top: 100, left: 130),
              //   height: 40,
              //   child: const Text(
              //     'Start Your Journey',
              //     style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //       fontSize: 18,
              //       color: Colors.black,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getCategoriesContainer(String categoryName, Route route) {
    return Container(
      padding: EdgeInsets.only(right: 20,left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => Future.delayed(const Duration(milliseconds: 20), () {
              Navigator.push(
                context,
                route,
              );
            }),
            child: Container(
              padding: const EdgeInsets.only(top: 8.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0.2,0.8),
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 0.3,
                      spreadRadius: 0.7,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: Align(
                child: Image.asset(
                  'images/logo.png',
                  height: 40,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            categoryName ?? "",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget getDriverRow(
      {required String name,
      required String carNo,
      required String carColor,
      required String carName,
      required carType}) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: carType == "quick-go"
                    ? AppColors().greenAccentColor
                    : primaryGreen,
                borderRadius: BorderRadius.circular(20),
                boxShadow: shadowList,
              ),
              child: Align(
                child: Image.asset(
                  'images/${carType}.png',
                  fit: BoxFit.contain,
                  height: 50,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(left: 2, right: 2, top: 15, bottom: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: shadowList,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Captain Name",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(name),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Car Name",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(child: Text(carName)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Car No",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(carNo),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
