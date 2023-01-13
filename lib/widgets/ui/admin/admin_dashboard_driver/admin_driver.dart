// import 'package:flutter/material.dart';
// import 'package:users_app/configuraton/configuration.dart';
// import 'package:users_app/global/colors.dart';
// import 'package:users_app/global/global.dart';
// import 'package:users_app/models/drivers_model.dart';
// import 'package:users_app/widgets/ui/admin/admin_dashboard_driver/admin_dashboard_driver_detail_widget.dart';

// class AdminDashboardDriverWidget extends StatefulWidget {
//   final List<DriverData> allDrivers;
//   const AdminDashboardDriverWidget({required this.allDrivers,
//    Key? key})
//       : super(key: key);

//   @override
//   State<AdminDashboardDriverWidget> createState() =>
//       _AdminDashboardDriverWidgetState();
// }

// class _AdminDashboardDriverWidgetState
//     extends State<AdminDashboardDriverWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: const Text("All Drivers"),
//       // ),
//       body: Container(
//               width: double.infinity,
//               decoration: BoxDecoration(color: Colors.teal),
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                         padding: EdgeInsets.all(20),
//                         child: Row(
//                           // mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                              IconButton(onPressed: (){
//                               Navigator.pop(context);
//                             }, icon: Icon(Icons.arrow_back)),
//                             SizedBox(width: getWidth(context)*0.25,),
//                             Text(
//                               "Driver",
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.normal,
//                                   fontSize: 30),
//                             )
//                           ],
//                         )),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.05),
//                     Expanded(
//                         child: Container(
//                             // height: MediaQuery.of(con/text).size.height * 0.50,
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(60),
//                                     topRight: Radius.circular(60))),
//                             child: Padding(
//                                 padding: EdgeInsets.all(20),
//                                 child: SizedBox(
//                                   width: MediaQuery.of(context).size.width,
//                                   height: MediaQuery.of(context).size.height *
//                                       0.65,
//                                   child: SingleChildScrollView(
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceAround,
//                                       children: [
// getAllDriver()
//                                       ])
//                                   ))
  
                            
//               )))]))
//     );
  
  
//   }

//   getAllDriver() {
//     return ListView.builder(
//         shrinkWrap: true,
//         itemCount: widget.allDrivers.length,
//         physics: const ScrollPhysics(
//           parent: ScrollPhysics(),
//         ),
//         itemBuilder: (context, index) {
//           return Column(
//             children: [
//               GestureDetector(
//                 onTap: (){
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardDriverDetailWidget(driverData: widget.allDrivers[index],)));
//                 },
//                 child: getDriverRow(
//                   clr: Colors.teal,
//                     name: widget.allDrivers[index].name ?? "Ali",
//                     carNo: widget.allDrivers[index].car_number ?? "34er",
//                     carColor: widget.allDrivers[index].car_color ?? "blue",
//                     carName: widget.allDrivers[index].car_model ?? "BMW",
//                     carType: widget.allDrivers[index].car_type ?? "quick-van"),
//               ),
//               getDriverRow(name: "Talha Khan", 
//               carNo: "AU-437", 
//               carColor: "white",
//                carName: "Suzuki",
//                 carType: "quick-go"),

               
//             ],
//           );
//         });
//   }

//   Widget getDriverRow(
//       {required String name,
//       required String carNo,
//       required String carColor,
//       required String carName,
//       required carType, Color? clr}) {
//     return Container(
//       padding: const EdgeInsets.all(10.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Expanded(
//             flex: 1,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: carType == "quick-go"
//                     ? AppColors().greenAccentColor
//                     : primaryGreen,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: shadowList,
//               ),
//               child: Align(
//                 child: Image.asset(
//                   'images/$carType.png',
//                   fit: BoxFit.contain,
//                   height: 50,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(width: getWidth(context)*0.015,),
//           Expanded(
//             flex: 2,
//             child: Container(
//               padding:
//                   const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
//               decoration: BoxDecoration(
//                 color:  carType == "quick-go"
//                     ? AppColors().primaryColor
//                     : carType=="quick-bolan"?Colors.amberAccent:Colors.grey,
//                 boxShadow: shadowList,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         "Captain Name",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       Text(name),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         "Car Name",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       Text(carName),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         "Car No",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       Text(carNo),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
          
//         ],
//       ),
//     );
//   }

// }

import 'package:flutter/material.dart';

class Driver extends StatefulWidget {
  const Driver({super.key});

  @override
  State<Driver> createState() => _DriverState();
}

class _DriverState extends State<Driver> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.teal),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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

                                      ])
                                  ))
  
                            
              )))]))));
  }}
           