import 'package:flutter/material.dart';
import 'package:users_app/global/colors.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/models/drivers_model.dart';
import 'package:url_launcher/url_launcher.dart' as launch;

class DashboardDriverDetailWidget extends StatefulWidget {
  final DriverData driverData;
  DashboardDriverDetailWidget({required this.driverData, Key? key})
      : super(key: key);

  @override
  State<DashboardDriverDetailWidget> createState() =>
      _DashboardDriverDetailWidgetState();
}

class _DashboardDriverDetailWidgetState
    extends State<DashboardDriverDetailWidget> {
  @override
  Widget build(BuildContext context) {
    double height = getHeight(context);
    double width = getWidth(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.driverData.name ?? "Driver"),
      ),
      body: Container(
        decoration: backGroundImage(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                getCarInfo(width),
                getDiverInfo(),
                SizedBox(height: 20,),
                WidgetCarInfo(),
                // Text(widget.driverData.car_color ?? ""),
                // Text(widget.driverData.car_model ?? ""),
                // Text(widget.driverData.car_type ?? ""),
                // Text(widget.driverData.id ?? ""),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getCarInfo(double width) {
    return Image.asset(
      "images/${widget.driverData.car_type}.png",
      width: width,
      height: 300,
      fit: BoxFit.contain,
    );
  }

  Widget getDiverInfo() {
    return ListTile(
      tileColor: AppColors.primaryColor,
      subtitle: Text("Name"),
      title: Text(widget.driverData.name ?? ""),
      trailing: CircleAvatar(
          backgroundColor: AppColors.whiteColor,
          child: IconButton(
              onPressed: () {
                getCall(widget.driverData.phone ?? "");
              },
              icon: Icon(
                Icons.call,
                color: AppColors.primaryColor,
              ))),
    );
  }

  WidgetCarInfo()
  {
    return ListTile(
      tileColor: AppColors.primaryColor,
      subtitle: Text("car Type"),
      title: Text(widget.driverData.car_type ?? ""),
      trailing: CircleAvatar(
          backgroundColor: AppColors.whiteColor,
          child: IconButton(
              onPressed: () {
                getCall(widget.driverData.phone ?? "");
              },
              icon: Icon(
                Icons.call,
                color: AppColors.primaryColor,
              ))),
    );
  }

  getCall(String contactNo) {
    launch.launchUrl(Uri(
      scheme: 'tel',
      path: contactNo,
    ));
  }
}
