import 'package:flutter/material.dart';
import 'package:users_app/configuraton/configuration.dart';
import 'package:users_app/global/colors.dart';
import 'package:users_app/models/drivers_model.dart';
import 'package:users_app/widgets/ui/admin/admin_dashboard_driver/admin_dashboard_driver_detail_widget.dart';

class AdminDashboardDriverWidget extends StatefulWidget {
  final List<DriverData> allDrivers;
  const AdminDashboardDriverWidget({required this.allDrivers, Key? key})
      : super(key: key);

  @override
  State<AdminDashboardDriverWidget> createState() =>
      _AdminDashboardDriverWidgetState();
}

class _AdminDashboardDriverWidgetState
    extends State<AdminDashboardDriverWidget> {

      @override
  void initState() {
    // TODO: implement initState
    getAllDriver();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Driver"),
      ),
      body: SingleChildScrollView(child: Column(children: [getAllDriver()])),
    );
  }

  getAllDriver() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.allDrivers.length,
        physics: const ScrollPhysics(
          parent: ScrollPhysics(),
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Navigator.push(context,
               MaterialPageRoute(builder: (context)=>
               DashboardDriverDetailWidget(
                driverData: widget.allDrivers[index],)));
            },
            child: getDriverRow(
                name: widget.allDrivers[index].name ?? "",
                carNo: widget.allDrivers[index].car_number ?? "",
                carColor: widget.allDrivers[index].car_color ?? "",
                carName: widget.allDrivers[index].car_model ?? "",
                carType: widget.allDrivers[index].car_type ?? "quick-van"),
                
          );
        });
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
                  'images/$carType.png',
                  fit: BoxFit.contain,
                  height: 50,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
               padding: EdgeInsets.all(20),
               decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(60),
                                    topRight: Radius.circular(60))),
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
