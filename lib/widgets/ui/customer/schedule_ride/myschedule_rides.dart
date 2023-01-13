
import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:users_app/models/trips_history_model.dart';

import '../../../../assistants/assistant_methods.dart';
import '../../../../assistants/geofire_assistant.dart';
import '../../../../configuraton/configuration.dart';
import '../../../../global/colors.dart';
import '../../../../global/global.dart';
import '../../../../infoHandler/app_info.dart';
import '../../../../mainScreens/rate_driver_screen.dart';
import '../../../../mainScreens/select_nearest_active_driver_screen.dart';
import '../../../../models/active_nearby_available_drivers.dart';
import '../../../pay_fare_amount_dialog.dart';
import '../../../providers/schedule_ride_provider.dart';
import '../../chat/chat_design.dart';


class ScheduledRidesTabPage extends StatefulWidget {
  TripsHistoryModel scheduleTrip;
  var chat;
  ScheduledRidesTabPage({Key? key, required this.scheduleTrip,required this.chat}) : super(key: key);

  @override
  _ScheduledRidesTabPageState createState() => _ScheduledRidesTabPageState();
}



class _ScheduledRidesTabPageState extends State<ScheduledRidesTabPage> {
  int noOfSeat = 1;
  double searchLocationContainerHeight = 300;
  double waitingResponseFromDriverContainerHeight = 0;
  double assignedDriverInfoContainerHeight = 0;

  Position? userCurrentPosition;
  var geoLocator = Geolocator();

  LocationPermission? _locationPermission;
  double bottomPaddingOfMap = 0;


  List<LatLng> pLineCoOrdinatesList = [];
  Set<Polyline> polyLineSet = {};

  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

  String userName = "your Name";
  String userEmail = "your Email";

  bool activeNearbyDriverKeysLoaded = false;
  BitmapDescriptor? activeNearbyIcon;

  List<ActiveNearbyAvailableDrivers> onlineNearByAvailableDriversList = [];

  DatabaseReference? referenceRideRequest;
  String driverRideStatus = "Driver is Coming";
  StreamSubscription<DatabaseEvent>? tripRideRequestInfoStreamSubscription;

  String userRideRequestStatus = "";
  bool requestPositionInfo = true;
  DateTime? date;
  TimeOfDay? time;
  listner(){
    var d = Provider.of<ScheduleRideProvider>(context, listen: false)
        .onValue();

    tripRideRequestInfoStreamSubscription =
        d.listen((eventSnap) async {


          if (eventSnap.snapshot.value == null) {
            return;
          }
          // print("event lisnter --->> ${(eventSnap.snapshot.value as Map)["scheduleTime"]} ${(eventSnap.snapshot.value as Map)["scheduleDate"]}");

          if ((eventSnap.snapshot.value as Map)["car_details"] != null) {
            setState(() {
              driverCarDetails =
                  (eventSnap.snapshot.value as Map)["car_details"].toString();
            });
          }

          if ((eventSnap.snapshot.value as Map)["driverPhone"] != null) {
            setState(() {
              driverPhone =
                  (eventSnap.snapshot.value as Map)["driverPhone"].toString();
            });
          }

          if ((eventSnap.snapshot.value as Map)["driverName"] != null) {
            setState(() {
              driverName =
                  (eventSnap.snapshot.value as Map)["driverName"].toString();
            });
          }

          if ((eventSnap.snapshot.value as Map)["status"] != null) {
            userRideRequestStatus =
                (eventSnap.snapshot.value as Map)["status"].toString();
          }

          if ((eventSnap.snapshot.value as Map)["driverLocation"] != null) {
            double driverCurrentPositionLat = double.parse(
                (eventSnap.snapshot.value as Map)["driverLocation"]["latitude"]
                    .toString());
            double driverCurrentPositionLng = double.parse(
                (eventSnap.snapshot.value as Map)["driverLocation"]["longitude"]
                    .toString());

            LatLng driverCurrentPositionLatLng =
            LatLng(driverCurrentPositionLat, driverCurrentPositionLng);

            //status = accepted
            if (userRideRequestStatus == "accepted") {
              // DateTime dt = DateTime.parse('${(eventSnap.snapshot.value as Map)["scheduleDate"]} ${(eventSnap.snapshot.value as Map)["scheduleTime"]}:00');
              // DateTime dt2 = dt.subtract(Duration(minutes: 5));
            }
            if (userRideRequestStatus == "started") {
              updateArrivalTimeToUserPickupLocation(driverCurrentPositionLatLng);
            }
            //status = arrived
            if (userRideRequestStatus == "arrived") {
              setState(() {
                driverRideStatus = "Driver has Arrived";
              });
            }

            //status = ontrip
            if (userRideRequestStatus == "ontrip") {
              updateReachingTimeToUserDropOffLocation(driverCurrentPositionLatLng);
            }
            //status = ended
            if (userRideRequestStatus == "ended") {
              if ((eventSnap.snapshot.value as Map)["fareAmount"] != null) {
                double fareAmount = double.parse(
                    (eventSnap.snapshot.value as Map)["fareAmount"].toString());

                var response = await showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext c) => PayFareAmountDialog(
                    fareAmount: fareAmount,
                  ),
                );

                if (response == "cashPayed") {
                  //user can rate the driver now
                  if ((eventSnap.snapshot.value as Map)["driverId"] != null) {
                    String assignedDriverId =
                    (eventSnap.snapshot.value as Map)["driverId"].toString();

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => RateDriverScreen(
                              assignedDriverId: assignedDriverId,
                            )));

                    referenceRideRequest!.onDisconnect();
                    tripRideRequestInfoStreamSubscription!.cancel();
                  }
                }
              }
            }
          }
        });
  }

  @override
  Widget build(BuildContext context) {

    // print("here is data ${widget.scheduleTrip}");
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:Colors.grey.shade300,

      body: ListView.builder(
        itemCount: 1,
        shrinkWrap: true,
        padding: EdgeInsets.all(10),
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
                padding: const EdgeInsets.only(left: 0.0,right: 0,bottom: 0),
                child:       Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 30,
                      decoration:const BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)
                          )
                      ),
                      child:const  Center(
                        child: Text("Scheduled Trip",style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15
                        ),),
                      ),
                    ),
                    const SizedBox(height: 5,),
                   widget.scheduleTrip.driverId=="waiting"?SizedBox(): Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          CircleAvatar(
                            radius:20,
                            foregroundImage:Image.asset(
                              "images/car_logo.png",
                              fit: BoxFit.fill,
                            ).image ,
                          ),

                          Column(
                            children: [
                              Text("${widget.scheduleTrip.driverName}",style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14
                              ),)
                            ],
                          ),
                          // Image.asset(
                          //   "images/car_logo.png",
                          //   width: 100,
                          // ),


                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              // Text("${widget.scheduleTrip.}",style: TextStyle(
                              //     color: Colors.black45,
                              //     fontWeight: FontWeight.w400,
                              //     fontSize: 12
                              // ),),
                              Container(
                                width: size.width*0.35,
                                child: Text(DateFormat().format(DateTime.parse("${widget.scheduleTrip.time}")),style: const TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12
                                ),),
                              ),
                              Text("${widget.scheduleTrip.fareAmount}",style: const TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12
                              ),)
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    /// Fromm
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Column(
                          children: [
                            Container(
                              width: 50,
                              child: const Text("From:",style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14
                              ),),
                            )
                          ],
                        ),
                        Container(
                          width: 220,
                          child:  Text(
                            "${widget.scheduleTrip.originAddress}",
                            style:  const TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.w600,
                                fontSize: 13
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    /// to
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 50,
                              child: const Text("To:",style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14
                              ),),
                            )
                          ],
                        ),
                        Container(
                          width: 220,
                          child:  Text(
                            "${widget.scheduleTrip.destinationAddress}",
                            style:  const TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.w600,
                                fontSize: 13
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    /// datae and calender shown here
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children:  [
                            const Icon(Icons.calendar_month,color: Colors.black,size: 20,),
                            const SizedBox(width: 5,),
                            Text(DateFormat.yMMMMd('en_US') .format(DateTime.parse("${widget.scheduleTrip.scheduleDate}")))
                          ],
                        ),
                        Row(
                          children:  [
                            const Icon(Icons.timelapse,color: Colors.black,size: 20,),
                            const SizedBox(width: 5,),
                            Text("${widget.scheduleTrip.scheduletime.toString()}")
                          ],
                        ),

                      ],
                    ),
                    const SizedBox(height: 15,),

                    /// call chat bcancel button is here
                    widget.scheduleTrip.driverId=="waiting"?
                    /// accept button is here
                    Container(
                      width: size.width*0.7,
                      padding: EdgeInsets.only(left:20,right: 20,top: 10,bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                        border:Border.all(
                            color: Colors.green,
                            width: 0.8
                        ),
                      ),
                      child: Center(
                        child: Text(
                          widget.scheduleTrip.status!="started"? widget.scheduleTrip.driverId.toString().toUpperCase():"On The way",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),

                        ),
                      ),
                    ):
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // /// cancell buttonis her
                            // IconButton(
                            //     onPressed: () {
                            //       showDialog(context: context, builder: (BuildContext context){
                            //         return StatefulBuilder(
                            //
                            //           builder: (BuildContext context, void Function(void Function()) setState) {
                            //             return AlertDialog(
                            //               title: const Text("REQUEST RIDE"),
                            //               content:Column(
                            //                 mainAxisSize: MainAxisSize.min,
                            //                 crossAxisAlignment: CrossAxisAlignment.start,
                            //                 children: [
                            //                   const Text("Pick Point",style: TextStyle(fontWeight: FontWeight.bold),),
                            //                   Text(widget.scheduleTrip?.originAddress??""),
                            //                   const Text("Destination Point",style: TextStyle(fontWeight: FontWeight.bold)),
                            //                   Text(widget.scheduleTrip?.destinationAddress??""),
                            //                   Row(
                            //                     children: [
                            //                       const Icon(
                            //                         Icons.event_seat,
                            //                         color: AppColors.primaryColor,
                            //                       ),
                            //                       const SizedBox(
                            //                         width: 12.0,
                            //                       ),
                            //                       Column(
                            //                         crossAxisAlignment: CrossAxisAlignment.start,
                            //                         children: [
                            //                           const Text(
                            //                             "No of Seats",
                            //                             style:
                            //                             TextStyle(color: Colors.grey, fontSize: 12),
                            //                           ),
                            //                           Text(
                            //                             '${noOfSeat}',
                            //                             style: const TextStyle(
                            //                                 color: Colors.grey, fontSize: 14),
                            //                           ),
                            //                         ],
                            //                       ),
                            //                       const Spacer(),
                            //                       IconButton(
                            //                           onPressed: noOfSeat<6 ? () {
                            //                             setState(() {
                            //                               noOfSeat++;
                            //                             });
                            //                           }:null,
                            //                           icon: Icon(Icons.add,color:AppColors.primaryColor,)),
                            //                       IconButton(
                            //                           onPressed: noOfSeat>1 ? () {
                            //                             setState(() {
                            //                               noOfSeat--;
                            //                             });
                            //                           }:null,
                            //                           icon: Icon(Icons.remove,color:AppColors.primaryColor,))
                            //                     ],
                            //                   ),
                            //
                            //                 ],
                            //
                            //               ),
                            //               actions: [
                            //                 ElevatedButton(
                            //                   onPressed: () {
                            //                     saveRideRequestInformation();
                            //
                            //                   },
                            //                   style: ElevatedButton.styleFrom(
                            //                       primary: AppColors.primaryColor,
                            //                       textStyle: const TextStyle(
                            //                           fontSize: 16, fontWeight: FontWeight.bold)),
                            //                   child: const Text(
                            //                     "Schedule Ride",
                            //                   ),
                            //                 ),
                            //               ],
                            //             );
                            //           },
                            //         );
                            //       });
                            //     },
                            //     icon: const Icon(
                            //       Icons.car_repair,
                            //       color: AppColors.primaryColor,
                            //     )),
                            widget.chat ?  IconButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatDesign(tripsHistoryModel: widget.scheduleTrip,)));
                                },
                                icon: const Icon(
                                  Icons.message,
                                  color: AppColors.primaryColor,
                                )):const SizedBox(),
                            // const SizedBox(width: 20,),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.call,
                                  color: AppColors.primaryColor,
                                )),
                            /// accept button is here

                          ],
                        ),
                        SizedBox(height: 10,),

                        /// start and accept button is here s
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            /// cancell buttonis her
                            InkWell(
                              onTap: (){
                                FirebaseDatabase.instance.ref()
                                    .child("All Ride Requests")
                                    .child(widget.scheduleTrip.key!)
                                    .remove().then((value)
                                {
                                  FirebaseDatabase.instance.ref()
                                      .child("drivers")
                                      .child(currentFirebaseUser!.uid)
                                      .child("newRideStatus")
                                      .set("idle");
                                }).then((value)
                                {
                                  FirebaseDatabase.instance.ref()
                                      .child("drivers")
                                      .child(currentFirebaseUser!.uid)
                                      .child("tripsHistory")
                                      .child(widget.scheduleTrip.key!)
                                      .remove();
                                }).then((value)
                                {
                                  Fluttertoast.showToast(msg: "Ride Request has been Cancelled, Successfully.");
                                  Provider.of<ScheduleRideProvider>(context, listen: false)
                                      .getScheduleRide(context);
                                  setState(() {

                                  });
                                });

                              },
                              child: Container(
                                width: size.width*0.6,
                                padding: EdgeInsets.only(left:15,right: 15,top: 10,bottom: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border:Border.all(
                                      color: Colors.red,
                                      width: 0.8
                                  ),
                                ),
                                child:Center(
                                  child: const Text(
                                    "Cancel Ride",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),

                                  ),
                                ),
                              ),
                            ),
                            // /// accept button is here
                            // Container(
                            //   width: size.width*0.35,
                            //   padding: EdgeInsets.only(left:20,right: 20,top: 10,bottom: 10),
                            //   decoration: BoxDecoration(
                            //     color: Colors.green,
                            //     borderRadius: BorderRadius.circular(8),
                            //     border:Border.all(
                            //         color: Colors.green,
                            //         width: 0.8
                            //     ),
                            //   ),
                            //   child:const Center(
                            //     child: Text(
                            //       "Start Ride",
                            //       style: TextStyle(
                            //         color: Colors.white,
                            //         fontSize: 13,
                            //         fontWeight: FontWeight.w500,
                            //       ),
                            //
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 10,),
                  ],
                )
            ),
          );
        },),
    );
  }
  saveRideRequestInformation() {
    //1. save the RideRequest Information
    referenceRideRequest = FirebaseDatabase.instance
        .ref()
        .child("All Ride Requests")
        .push(); //push is for generating a random unique id

    var originLocation =
        Provider.of<AppInfo>(context, listen: false).userPickUpLocation;
    var destinationLocation =
        Provider.of<AppInfo>(context, listen: false).userDropOffLocation;

    //for lat and lang
    Map originLocationMap = {
      //yh ggogle map ni hai yh bs aik obj type hai jo key ki basis py work krta hai or save krta
      //"key" : value
      "latitude": widget.scheduleTrip?.origin["latitude"],
      "longitude": widget.scheduleTrip?.origin["longitude"],
    };

    Map destinationLocationMap = {
      //yh ggogle map ni hai yh bs aik obj type hai jo key ki basis py work krta hai or save krta
      //"key" : value
      "latitude": widget.scheduleTrip?.destination["latitude"],
      "longitude":widget.scheduleTrip?.destination["longitude"],
    };

    //saving in databse the complete information of user
    Map userInformationMap = {
      "origin": originLocationMap,
      "destination": destinationLocationMap,
      "time": DateTime.now().toString(),
      "userName": userModelCurrentInfo!.name,
      "userPhone": userModelCurrentInfo!.phone,
      "originAddress": widget.scheduleTrip.originAddress??"",
      "destinationAddress": widget.scheduleTrip.originAddress??"",
      "driverId": "waiting",
      "rideType": "scheduleRide",
      "noOfSeats": '$noOfSeat',
      "scheduleTime": "${DateFormat('hh:mm a').format(DateFormat("h:m").parse("${time?.hour}:${time?.minute}"))}",
      "scheduleDate": DateFormat('yyyy-MM-dd').format(date!),

    };

    referenceRideRequest!.set(userInformationMap);

    tripRideRequestInfoStreamSubscription =
        referenceRideRequest!.onValue.listen((eventSnap) async {
          if (eventSnap.snapshot.value == null) {
            return;
          }

          if ((eventSnap.snapshot.value as Map)["car_details"] != null) {
            setState(() {
              driverCarDetails =
                  (eventSnap.snapshot.value as Map)["car_details"].toString();
            });
          }

          if ((eventSnap.snapshot.value as Map)["driverPhone"] != null) {
            setState(() {
              driverPhone =
                  (eventSnap.snapshot.value as Map)["driverPhone"].toString();
            });
          }

          if ((eventSnap.snapshot.value as Map)["driverName"] != null) {
            setState(() {
              driverName =
                  (eventSnap.snapshot.value as Map)["driverName"].toString();
            });
          }

          if ((eventSnap.snapshot.value as Map)["status"] != null) {
            userRideRequestStatus =
                (eventSnap.snapshot.value as Map)["status"].toString();
          }

          if ((eventSnap.snapshot.value as Map)["driverLocation"] != null) {
            double driverCurrentPositionLat = double.parse(
                (eventSnap.snapshot.value as Map)["driverLocation"]["latitude"]
                    .toString());
            double driverCurrentPositionLng = double.parse(
                (eventSnap.snapshot.value as Map)["driverLocation"]["longitude"]
                    .toString());

            LatLng driverCurrentPositionLatLng =
            LatLng(driverCurrentPositionLat, driverCurrentPositionLng);

            //status = accepted
            if (userRideRequestStatus == "accepted") {
              updateArrivalTimeToUserPickupLocation(driverCurrentPositionLatLng);
            }

            //status = arrived
            if (userRideRequestStatus == "arrived") {
              setState(() {
                driverRideStatus = "Driver has Arrived";
              });
            }

            //status = ontrip
            if (userRideRequestStatus == "ontrip") {
              updateReachingTimeToUserDropOffLocation(driverCurrentPositionLatLng);
            }
            //status = ended
            if (userRideRequestStatus == "ended") {
              if ((eventSnap.snapshot.value as Map)["fareAmount"] != null) {
                double fareAmount = double.parse(
                    (eventSnap.snapshot.value as Map)["fareAmount"].toString());

                var response = await showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext c) => PayFareAmountDialog(
                    fareAmount: fareAmount,
                  ),
                );

                if (response == "cashPayed") {
                  //user can rate the driver now
                  if ((eventSnap.snapshot.value as Map)["driverId"] != null) {
                    String assignedDriverId =
                    (eventSnap.snapshot.value as Map)["driverId"].toString();

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => RateDriverScreen(
                              assignedDriverId: assignedDriverId,
                            )));

                    referenceRideRequest!.onDisconnect();
                    tripRideRequestInfoStreamSubscription!.cancel();
                  }
                }
              }
            }
          }
        });

    onlineNearByAvailableDriversList =
        GeoFireAssistant.activeNearbyAvailableDriversList;
    searchNearestOnlineDrivers();
  }

  updateArrivalTimeToUserPickupLocation(driverCurrentPositionLatLng) async {
    if (requestPositionInfo == true) {
      requestPositionInfo = false;

      LatLng userPickUpPosition =
      LatLng(userCurrentPosition!.latitude, userCurrentPosition!.longitude);

      var directionDetailsInfo =
      await AssistantMethods.obtainOriginToDestinationDirectionDetails(
        driverCurrentPositionLatLng,
        userPickUpPosition,
      );

      if (directionDetailsInfo == null) {
        return;
      }

      setState(() {
        driverRideStatus =
        "Driver is Coming :: ${directionDetailsInfo.duration_text}";
      });

      requestPositionInfo = true;
    }
  }

  updateReachingTimeToUserDropOffLocation(driverCurrentPositionLatLng) async {
    if (requestPositionInfo == true) {
      requestPositionInfo = false;

      var dropOffLocation =
          Provider.of<AppInfo>(context, listen: false).userDropOffLocation;

      LatLng userDestinationPosition = LatLng(
          dropOffLocation!.locationLatitude!,
          dropOffLocation!.locationLongitude!);

      var directionDetailsInfo =
      await AssistantMethods.obtainOriginToDestinationDirectionDetails(
        driverCurrentPositionLatLng,
        userDestinationPosition,
      );

      if (directionDetailsInfo == null) {
        return;
      }

      setState(() {
        driverRideStatus =
        "Going towards Destination :: ${directionDetailsInfo.duration_text}";
      });

      requestPositionInfo = true;
    }
  }

  searchNearestOnlineDrivers() async {
    //no active driver available
    if (onlineNearByAvailableDriversList.length == 0) {
      //cancel/delete the RideRequest Information
      referenceRideRequest!.remove();
      setState(() {
        polyLineSet.clear();
        markersSet.clear();
        circlesSet.clear();
        pLineCoOrdinatesList.clear();
      });

      Fluttertoast.showToast(
          msg:
          "No Online Nearest Driver Available. Search Again after some time, Restarting App Now.");

      //dealy kr re restart 3 sec
      // Future.delayed(const Duration(milliseconds: 4000), ()
      // {
      //   Navigator.pop(context);
      //   // SystemNavigator.pop();//refresh our app
      // });

      return;
    }

    //active driver available
    await retrieveOnlineDriversInformation(onlineNearByAvailableDriversList);

    var response = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (c) => SelectNearestActiveDriversScreen(
                referenceRideRequest: referenceRideRequest)));

    if (response == "driverChoosed") {
      FirebaseDatabase.instance
          .ref()
          .child("drivers")
          .child(chosenDriverId!)
          .once()
          .then((snap) {
        if (snap.snapshot.value != null) {
          //send notification to that specific driver
          sendNotificationToDriverNow(chosenDriverId!);

          //Display Waiting Response UI from a Driver
          showWaitingResponseFromDriverUI();

          //Response from a Driver
          FirebaseDatabase.instance
              .ref()
              .child("drivers")
              .child(chosenDriverId!)
              .child("newRideStatus")
              .onValue
              .listen((eventSnapshot) {
            //1. driver has cancel the rideRequest :: Push Notification
            // (newRideStatus = idle)
            if (eventSnapshot.snapshot.value == "idle") {
              Fluttertoast.showToast(
                  msg:
                  "The driver has cancelled your request. Please choose another driver.");

              Future.delayed(const Duration(milliseconds: 3000), () {
                Fluttertoast.showToast(msg: "Please Restart App Now.");

                // SystemNavigator.pop();
              });
            }

            //2. driver has accept the rideRequest :: Push Notification
            // (newRideStatus = accepted)
            if (eventSnapshot.snapshot.value == "accepted") {
              //design and display ui for displaying assigned driver information
              showUIForAssignedDriverInfo();
            }
          });
        } else {
          Fluttertoast.showToast(msg: "This driver do not exist. Try again.");
        }
      });
    }
  }

  showUIForAssignedDriverInfo() {
    setState(() {
      waitingResponseFromDriverContainerHeight = 0;
      searchLocationContainerHeight = 0;
      assignedDriverInfoContainerHeight = 240;
    });
  }

  showWaitingResponseFromDriverUI() {
    setState(() {
      searchLocationContainerHeight = 0;
      waitingResponseFromDriverContainerHeight = 220;
    });
  }

  sendNotificationToDriverNow(String chosenDriverId) {
    //assign/SET rideRequestId to newRideStatus in
    // Drivers Parent node for that specific choosen driver
    FirebaseDatabase.instance
        .ref()
        .child("drivers")
        .child(chosenDriverId)
        .child("newRideStatus")
        .set(referenceRideRequest!.key);

    //automate the push notification service
    FirebaseDatabase.instance
        .ref()
        .child("drivers")
        .child(chosenDriverId)
        .child("token")
        .once()
        .then((snap) {
      if (snap.snapshot.value != null) {
        String deviceRegistrationToken = snap.snapshot.value.toString();

        //send Notification Now
        AssistantMethods.sendNotificationToDriverNow(
          deviceRegistrationToken,
          referenceRideRequest!.key.toString(),
          context,
        );

        Fluttertoast.showToast(msg: "Notification sent Successfully.");
      } else {
        Fluttertoast.showToast(msg: "Please choose another driver.");
        return;
      }
    });
  }

  retrieveOnlineDriversInformation(List onlineNearestDriversList) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child("drivers");
    for (int i = 0; i < onlineNearestDriversList.length; i++) {
      await ref
          .child(onlineNearestDriversList[i].driverId.toString())
          .once()
          .then((dataSnapshot) {
        var driverKeyInfo =
            dataSnapshot.snapshot.value; //value le k aa ra db se
        dList.add(driverKeyInfo);
        //print("driver's key info" + dList.toString());
      });
    }
  }
}
