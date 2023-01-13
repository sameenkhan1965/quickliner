import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/widgets/my_drawer.dart';
import 'package:users_app/widgets/providers/admin/admin_dashboard_provider.dart';
import 'package:users_app/widgets/providers/admin/all_customer_provider.dart';
import 'package:users_app/widgets/providers/admin/all_rides_widget_provider.dart';
import 'package:users_app/widgets/providers/all_drivers_provider.dart';
import 'package:users_app/widgets/ui/admin/Salary/salary.dart';
import 'package:users_app/widgets/ui/admin/admin_dashboard_driver/admin_dashboard_driver_widget.dart';
import 'package:users_app/widgets/ui/admin/admin_dashboard_driver/admin_driver.dart';
import 'package:users_app/widgets/ui/admin/all_rides_filter/all_rides_widget.dart';
import 'package:users_app/widgets/ui/admin/fare/fares.dart';
import 'package:users_app/widgets/ui/rider/riders.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final GlobalKey<ScaffoldState> key = GlobalKey();
  void initState() {
    Provider.of<AdminDashBoardProvider>(context, listen: false)
        .getDashboardList();
    Provider.of<AllDriversProvider>(context, listen: false)
        .getAllDrivers(context);
    Provider.of<AllCustomersProviders>(context, listen: false)
        .getAllCustomers(context);
    Provider.of<AllRidesWigetProvider>(context,listen: false).getAllRides(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      key: key,
      drawer: SizedBox(
        width: 265,
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.black,
          ),
          child: MyDrawer(
            name: userModelCurrentInfo?.name,
            email: userModelCurrentInfo?.email,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.3,
            image: AssetImage('images/logo.png'),
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () {
                    key.currentState!.openDrawer();
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.menu,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ),
               Padding(
                 padding: const EdgeInsets.only(left:15.0),
                 child: Text("Admin", 
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
              ),
              ),
               ),
              getGridView(context),
            ],
          ),
        ),
      ),
    );
  }

  getGridView(BuildContext context) {
    return Consumer<AdminDashBoardProvider>(
      builder: (context, value, child) => Padding(
        padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.055),
        child: Container(
           height: MediaQuery.of(context).size.height*0.8,
              width: double.infinity,
             
             decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                 topRight: Radius.circular(40),
              ),
             ),
             padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.07),
          child: Column(
            children: [
              Wrap(
                spacing: 80,
                runSpacing: 40,
                children: [
                  Consumer<AllDriversProvider>(
                    builder: (context, drivers, child) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DriverDashboard(
                                    allDrivers: drivers.allDrivers)));
                      },
                      child: Container(
                        width: MediaQuery .of(context).size.width * 0.35,
          height: MediaQuery.of(context).size.height * 0.18,
          decoration:
              BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(35)),
                       
                        child: Center(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Driver", 
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700
                            )),
                            Text('${drivers.allDrivers.length}',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700
                            )),
                          ],
                        )),
                      ),
                    ),
                  ),
                  Consumer<AllCustomersProviders>(
                    builder: (context, customer, child) => GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => AdminDashboardDriverWidget(
                        //             allDrivers: drivers.allCustomers)),
                        // );

                        Navigator.push(context, MaterialPageRoute(builder: 
                        (ctx)=>Rider(allrider: customer.allCustomers,)));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                         height: MediaQuery.of(context).size.height * 0.18,
                          decoration:
                          BoxDecoration(color: Colors.amberAccent, borderRadius: BorderRadius.circular(35)),
                        
                        child: Center(child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Rider",
                             style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700
                            )
                            ),
                            Text('${customer.allCustomers.length}',
                             style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700
                            )
                            ),
                          ],
                        )),
                      ),
                    ),
                  ),
                  Consumer<AllRidesWigetProvider>(
                    builder: (context, customer, child) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllRidesWidget()),
                        );
                      },
                      child: Container(
                       
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.height * 0.18,
                      decoration:
                           BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(35)),
                        
                        child: Center(
                          
                          child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Rides",
                              style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700
                            )
                            ),
                            Text('${customer.allRides.length}',
                              style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700
                            )
                            ),
                          ],
                        )),
                      ),
                    ),
                  ),
                
                
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Fare()),
                        );
                      },
                      child: Container(
                       
                          width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.height * 0.18,
                      decoration:
                           BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(35)),
                        
                        child: Center(
                          
                          child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Fare",
                              style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700
                            )
                            ),
                            // Text('${customer.allRides.length}',
                            //   style: GoogleFonts.poppins(
                            //   fontWeight: FontWeight.w700
                            // )
                            // ),
                          ],
                        )),
                      ),
                    
                    
                    ),
                  
                
                 Consumer<AllDriversProvider>(
                    builder: (context, allderiver, child) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Salary(
                                   allDrivers: allderiver.allDrivers)),
                        );
                      },
                      child: Container(
                       
                          width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.height * 0.18,
                      decoration:
                           BoxDecoration(color: Colors.amberAccent, borderRadius: BorderRadius.circular(35)),
                        
                        child: Center(
                          
                          child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Salary",
                              style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700
                            )
                            ),
                            // Text('${customer.allRides.length}',
                            //   style: GoogleFonts.poppins(
                            //   fontWeight: FontWeight.w700
                            // )
                            // ),
                          ],
                        )),
                      ),
                    ),
                  ),
                
                
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
