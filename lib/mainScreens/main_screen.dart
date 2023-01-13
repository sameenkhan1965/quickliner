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
    Size size = MediaQuery.of(context).size;
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
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// custom hamburger button for drawer
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        sKey.currentState!.openDrawer();
                      },
                      child: const Icon(
                        Icons.menu,
                        color: Colors.black,
                      ),
                    ),
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
                    Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        border: Border.all(
                          color: Colors.grey.shade300
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Icon(Icons.person,color: AppColors.primaryColor,size: 40,),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height:size.height*0.015,
                ),
                Container(
                  height: 50,
                  child: TextFormField(
                    decoration: InputDecoration(

                      suffixIcon: Icon(Icons.settings,color: AppColors.blackColor,),
                        prefixIcon: Icon(Icons.search,color: AppColors.blackColor,),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder:  OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border:  OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        // label: Text("Search Brodcast"),
                        hintText: 'Search Broadcast',
                        hintStyle:TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade500
                        )
                    ),
                  ),
                ),
                SizedBox(
                  height:size.height*0.015,
                ),
                SizedBox(
                  height: size.height*0.15,
                  child: Consumer<TransportCategoryProvider>(
                    builder: (context, value, child) => ListView.builder(
                        shrinkWrap: true,
                        itemCount: categories.length,
                        scrollDirection: Axis.horizontal,

                        itemBuilder: (context, index) {
                          return getCategoriesContainer(
                               value.allCategories[index].transportName,
                               value.allCategories[index].route,
                               value.allCategories[index].transportImage,

                          );
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
      ),
    );
  }

  Widget getCategoriesContainer(String categoryName, var route, String imageId) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => Future.delayed(const Duration(milliseconds: 20), () {
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => route
          ),
        );
      }),
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: Colors.grey.shade200
                )
              ),
              // decoration: BoxDecoration(
              //     color: Colors.white,
              //     boxShadow: [
              //       BoxShadow(
              //         offset: Offset(0.2,0.8),
              //         color: Colors.black.withOpacity(0.4),
              //         blurRadius: 0.3,
              //         spreadRadius: 0.7,
              //       ),
              //     ],
              //     borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  child: Image.asset(
                    '${imageId}',
                    height: 40,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height*0.01,
            ),
            Text(
              categoryName ?? "",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget getDriverRow(
      {required String name,
      required String carNo,
      required String carColor,
      required String carName,
      required carType}) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Container(
            height: 80,
            margin: EdgeInsets.only(left:size.width*0.19,top: size.height*0.015),
            padding: EdgeInsets.only(left: size.width*0.12,right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: shadowList,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: size.height*0.015,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Captain Name:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.width*0.015,),
                    Text(name),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Car Name:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.width*0.015,),
                    Text(carName),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Car No",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.width*0.015,),
                    Text(carNo),
                  ],
                ),
              ],
            ),
          ),
          /// image container is here
          Container(
            width: 100,
            height: 110,
            decoration: BoxDecoration(
              color: carType == "quick-go"
                  ? AppColors.greenAccentColor
                  : primaryGreen,
              borderRadius: BorderRadius.circular(5),
              // boxShadow: shadowList,
            ),
            child: Align(
              child: Image.asset(
                'images/${carType}.png',
                fit: BoxFit.contain,
                height: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
