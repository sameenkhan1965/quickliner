import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/widgets/my_drawer.dart';
import 'package:users_app/widgets/providers/admin/admin_dashboard_provider.dart';
import 'package:users_app/widgets/providers/admin/all_customer_provider.dart';
import 'package:users_app/widgets/providers/all_drivers_provider.dart';
import 'package:users_app/widgets/ui/admin/admin_dashboard_driver/admin_dashboard_driver_widget.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.3,
            image: AssetImage('images/logo.png'),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    key.currentState!.openDrawer();
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.menu,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const Text("Admin"),
                getGridView(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getGridView(BuildContext context) {
    return Consumer<AdminDashBoardProvider>(
      builder: (context, value, child) => Row(
        children: [
          Wrap(
            children: [
              Consumer<AllDriversProvider>(
                builder: (context, drivers, child) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminDashboardDriverWidget(
                                allDrivers: drivers.allDrivers)));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        opacity: 0.3,
                        fit: BoxFit.fill,
                        image: AssetImage('images/img.png'),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                      color: value.dashboardContainerColor[0],
                    ),
                    child: Center(child: Column(
                      children: [
                        Text(value.dashboardList[0]),
                        Text('${drivers.allDrivers.length}'),
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
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: const DecorationImage(
                        opacity: 0.3,
                        fit: BoxFit.fill,
                        image: AssetImage('images/customer.png'),
                      ),
                      color: value.dashboardContainerColor[1],
                    ),
                    child: Center(child: Column(
                      children: [
                        Text(value.dashboardList[1]),
                        Text('${customer.allCustomers.length}'),
                      ],
                    )),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
