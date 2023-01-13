import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:users_app/assistants/assistant_methods.dart';
import 'package:users_app/global/colors.dart';
import 'package:users_app/models/trips_history_model.dart';

class RideDetail extends StatefulWidget {
  final TripsHistoryModel tripsHistoryModel;
  RideDetail({required this.tripsHistoryModel, Key? key}) : super(key: key);

  @override
  State<RideDetail> createState() => _RideDetailState();
}

class _RideDetailState extends State<RideDetail> {

  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  Position? userCurrentPosition;
  GoogleMapController? newGoogleMapController;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      padding: EdgeInsets.only(bottom: 10.0),
      mapType: MapType.normal,
      myLocationEnabled: true,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: true,
      initialCameraPosition: _kGooglePlex,
      polylines: {
        Polyline(
          color: AppColors.primaryColor,
          startCap: Cap.roundCap,
          geodesic: true,
          jointType: JointType.round,
          polylineId: PolylineId("1"),
          points: [
            LatLng(double.parse(widget.tripsHistoryModel.origin!["latitude"] ??"0.234"),double.parse(widget.tripsHistoryModel.origin!["longitude"]??"0.234")),
            LatLng(double.parse(widget.tripsHistoryModel.destination!["latitude"] ??"0.234"),double.parse(widget.tripsHistoryModel.destination!["longitude"]??"0.234")),
            // LatLng(widget.tripsHistoryModel.destination!["latitude"] ??0.234,widget.tripsHistoryModel.destination!["longitude"]??0.234),
          ]
        ),
      },
      // markers: markersSet,
      // circles: circlesSet,
      onMapCreated: (GoogleMapController controller) {
        _controllerGoogleMap.complete(controller);
        newGoogleMapController = controller;

        //for black theme google map
        // blackThemeGoogleMap();

        // setState(() {
        //   bottomPaddingOfMap = 240;
        // });

        locateUserPosition();
      },
    );
  }

  locateUserPosition() async {
    Position cPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    userCurrentPosition = cPosition;

    LatLng latLngPosition =
    LatLng(userCurrentPosition!.latitude, userCurrentPosition!.longitude);

    CameraPosition cameraPosition =
    CameraPosition(target: latLngPosition, zoom: 14);

    newGoogleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String humanReadableAddress =
    await AssistantMethods.searchAddressForGeographicCoOrdinates(
        userCurrentPosition!, context);

  }
}
