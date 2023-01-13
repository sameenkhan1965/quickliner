import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:users_app/configuraton/configuration.dart';
import 'package:users_app/global/colors.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/models/drivers_model.dart';
import 'package:users_app/models/user_model.dart';
import 'package:users_app/widgets/providers/admin/all_customer_provider.dart';


class DriverDashboard extends StatefulWidget {
  final List<DriverData> allDrivers;
   DriverDashboard({super.key, required this.allDrivers});

  @override
  State<DriverDashboard> createState() => _DriverDashboardState();
}

class _DriverDashboardState extends State<DriverDashboard> {
UserModel? userModelCurrentInfo;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Provider.of<AllCustomersProviders>(context, listen: false)
    //     .getAllCustomers(context);
    Query dbRef = FirebaseDatabase.instance.ref().child('users');
  DatabaseReference reference = FirebaseDatabase.
  instance.ref().child('users');
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      // appBar: AppBar(
      //   title: const Text("All Drivers"),
      // ),
      body: Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.teal),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             IconButton(onPressed: (){
                              Navigator.pop(context);
                            }, icon: Icon(Icons.arrow_back)),
                            SizedBox(width: getWidth(context)*0.25,),
                            Text(
                              "Driver",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 30),
                            )
                          ],
                        )),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Expanded(
                        child: Container(
                            // height: MediaQuery.of(con/text).size.height * 0.50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(60),
                                    topRight: Radius.circular(60))),
                            child: Padding(
                                padding: EdgeInsets.all(20),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height *
                                      0.65,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                          getAllCustomers()
                                      ])
                                  ))
  
                            
              )))]))
    );
  
  
  }
  
  getAllCustomers() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.allDrivers.length,
        physics: const ScrollPhysics(
          parent: ScrollPhysics(),
        ),
        itemBuilder: (context, index) {
          return getDriverRow(
                  clr: Colors.teal,
                    name: widget.allDrivers[index].name ?? "Ali",
                    carNo: widget.allDrivers[index].car_number ?? "34er",
                    carColor: widget.allDrivers[index].car_color ?? "blue",
                    carName: widget.allDrivers[index].car_model ?? "BMW",
                    carType: widget.allDrivers[index].car_type ?? "quick-van");
        });
  }

  Widget getDriverRow(
      {required String name,
      required String carNo,
      required String carColor,
      required String carName,
      required carType, Color? clr}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
        decoration: BoxDecoration(
          color:  carType == "quick-go"
              ? AppColors().primaryColor
              : carType=="quick-bolan"?Colors.amberAccent:Colors.grey,
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
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "User Type",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(carType),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "car color",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(carColor),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  }
           