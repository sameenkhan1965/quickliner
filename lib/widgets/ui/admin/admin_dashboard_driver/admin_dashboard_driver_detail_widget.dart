import 'package:flutter/material.dart';
import 'package:users_app/global/colors.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/models/drivers_model.dart';
import 'package:url_launcher/url_launcher.dart' as launch;

class DashboardDriverDetailWidget extends StatefulWidget {
  final DriverData driverData;
  DashboardDriverDetailWidget({required this.driverData, Key? key}) : super(key: key);

  @override
  State<DashboardDriverDetailWidget> createState() => _DashboardDriverDetailWidgetState();
}

class _DashboardDriverDetailWidgetState extends State<DashboardDriverDetailWidget> {
  @override
  Widget build(BuildContext context) {
    double height=getHeight(context);
    double width=getWidth(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.driverData.name??"Driver"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            getCarInfo(width),
            getDiverInfo(),
            Text(widget.driverData.car_color??""),
            Text(widget.driverData.car_model??""),
            Text(widget.driverData.car_type??""),
            Text(widget.driverData.id??""),
          ],
        ),
      ),
    );
  }
  Widget getCarInfo(double width)
  {
    return Image.asset( "images/${widget.driverData.car_type}.png",width: width,height: 300,fit: BoxFit.contain,);
  }
  Widget getDiverInfo()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
            Text(widget.driverData.name??""),
        CircleAvatar(backgroundColor: AppColors().primaryColor, child: IconButton(onPressed: (){
          getCall(widget.driverData.phone??"");
        }, icon: Icon(Icons.call,color: Colors.white,))),
      ],
    );
  }
  
  getCall(String contactNo)
  {
    launch.launchUrl(Uri(
      scheme: 'tel',
      path: contactNo,
    ));
  }
}
