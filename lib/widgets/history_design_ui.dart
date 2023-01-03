import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:users_app/assistants/assistant_methods.dart';
import 'package:users_app/assistants/geofire_assistant.dart';
import 'package:users_app/configuraton/configuration.dart';
import 'package:users_app/global/colors.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/infoHandler/app_info.dart';
import 'package:users_app/mainScreens/rate_driver_screen.dart';
import 'package:users_app/mainScreens/select_nearest_active_driver_screen.dart';
import 'package:users_app/models/active_nearby_available_drivers.dart';
import 'package:users_app/models/trips_history_model.dart';

import 'package:url_launcher/url_launcher.dart' as launch;
import 'package:users_app/widgets/pay_fare_amount_dialog.dart';

class HistoryDesignUIWidget extends StatefulWidget {
  TripsHistoryModel? tripsHistoryModel;

  HistoryDesignUIWidget({this.tripsHistoryModel});

  @override
  State<HistoryDesignUIWidget> createState() => _HistoryDesignUIWidgetState();
}

class _HistoryDesignUIWidgetState extends State<HistoryDesignUIWidget> {
  String formatDateAndTime(String dateTimeFromDB) {
    DateTime dateTime = DateTime.parse(dateTimeFromDB);

    // Dec 10                            //2022                         //1:12 pm
    String formattedDatetime =
        "${DateFormat.MMMd().format(dateTime)}, ${DateFormat.y().format(dateTime)} - ${DateFormat.jm().format(dateTime)}";

    return formattedDatetime;
  }

  double searchLocationContainerHeight = 300;
  double waitingResponseFromDriverContainerHeight = 0;
  double assignedDriverInfoContainerHeight = 0;

  Position? userCurrentPosition;
  var geoLocator = Geolocator();

  LocationPermission? _locationPermission;
  double bottomPaddingOfMap = 0;
  int noOfSeat = 1;

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

  checkIfLocationPermissionAllowed() async {
    _locationPermission = await Geolocator.requestPermission();

    if (_locationPermission == LocationPermission.denied) {
      _locationPermission = await Geolocator.requestPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.tripsHistoryModel!.car_details ?? "");
    print(widget.tripsHistoryModel!.status ?? "");
    return Container(
      color: Colors.black54,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //driver name + Fare Amount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Text(
                    "Driver : ${widget.tripsHistoryModel!.driverName ?? " driver"}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  "\$ " '${widget.tripsHistoryModel!.fareAmount ?? "0"}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 2,
            ),

            // car details
            Row(
              children: [
                const Icon(
                  Icons.car_repair,
                  color: Colors.black,
                  size: 28,
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  widget.tripsHistoryModel!.car_details ?? "Car Detail",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),

            //icon + pickup
            Row(
              children: [
                Image.asset(
                  "images/origin.png",
                  height: 26,
                  width: 26,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      widget.tripsHistoryModel!.originAddress ?? " address",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 14,
            ),

            //icon + dropOff
            Row(
              children: [
                Image.asset(
                  "images/destination.png",
                  height: 24,
                  width: 24,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      widget.tripsHistoryModel!.destinationAddress ?? "address",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 14,
            ),

            //icon + dropOff
            Row(
              children: [
                Icon(
                  Icons.event_seat,
                  color: AppColors().whiteColor,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    widget.tripsHistoryModel!.seats ?? "0",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors().whiteColor,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      showDialog(context: context, builder: (BuildContext context){
                        return StatefulBuilder(

                          builder: (BuildContext context, void Function(void Function()) setState) {
                            return AlertDialog(
                              title: Text("REQUEST RIDE"),
                              content:Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Pick Point",style: TextStyle(fontWeight: FontWeight.bold),),
                                  Text(widget.tripsHistoryModel?.originAddress??""),
                                  Text("Destination Point",style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text(widget.tripsHistoryModel?.destinationAddress??""),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.event_seat,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(
                                        width: 12.0,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "No of Seats",
                                            style:
                                            TextStyle(color: Colors.grey, fontSize: 12),
                                          ),
                                          Text(
                                            '${noOfSeat}',
                                            style: const TextStyle(
                                                color: Colors.grey, fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      IconButton(
                                          onPressed: noOfSeat<6 ? () {
                                            setState(() {
                                              noOfSeat++;
                                            });
                                          }:null,
                                          icon: Icon(Icons.add,color:AppColors().blackColor)),
                                      IconButton(
                                          onPressed: noOfSeat>1 ? () {
                                            setState(() {
                                              noOfSeat--;
                                            });
                                          }:null,
                                          icon: Icon(Icons.remove,color:AppColors().blackColor,))
                                    ],
                                  ),

                                ],

                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                      saveRideRequestInformation();

                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: primaryGreen,
                                      textStyle: const TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.bold)),
                                  child: const Text(
                                    "Schedule Ride",
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      });
                    },
                    icon: Icon(
                      Icons.car_repair,
                      color: AppColors().whiteColor,
                    )),
                SizedBox(width: 20,),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.call,
                      color: AppColors().whiteColor,
                    )),
              ],
            ),

            const SizedBox(
              height: 14,
            ),

            //trip time and date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(""),
                Text(
                  formatDateAndTime(widget.tripsHistoryModel!.time ??
                      DateTime.now().toString()),
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 2,
            ),
          ],
        ),
      ),
    );
  }

  getCall(String contactNo) {
    launch.launchUrl(Uri(
      scheme: 'tel',
      path: contactNo,
    ));
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
      "latitude": widget.tripsHistoryModel?.origin["latitude"],
      "longitude": widget.tripsHistoryModel?.origin["longitude"],
    };

    Map destinationLocationMap = {
      //yh ggogle map ni hai yh bs aik obj type hai jo key ki basis py work krta hai or save krta
      //"key" : value
      "latitude": widget.tripsHistoryModel?.destination["latitude"],
      "longitude":widget.tripsHistoryModel?.destination["longitude"],
    };

    //saving in databse the complete information of user
    Map userInformationMap = {
      "origin": originLocationMap,
      "destination": destinationLocationMap,
      "time": DateTime.now().toString(),
      "userName": userModelCurrentInfo!.name,
      "userPhone": userModelCurrentInfo!.phone,
      "originAddress": widget.tripsHistoryModel?.originAddress??"",
      "destinationAddress": widget.tripsHistoryModel?.originAddress??"",
      "driverId": "waiting",
      "rideType": "scheduleRide",
      "noOfSeats": '$noOfSeat',
      "scheduleTime":'$time',
      "scheduleDate":'$date',

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
