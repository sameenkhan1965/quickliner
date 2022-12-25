import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users_app/widgets/providers/admin/admin_dashboard_provider.dart';
import 'package:users_app/widgets/providers/all_drivers_provider.dart';
import 'package:users_app/widgets/ui/admin/admin_dashboard_driver/admin_dashboard_driver_widget.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  void initState() {
    Provider.of<AdminDashBoardProvider>(context, listen: false)
        .getDashboardList();
    Provider.of<AllDriversProvider>(context, listen: false)
        .getAllDrivers(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text("Admin"),

            getGridView(context),
          ],
        ),
      ),
    );
  }

  getGridView(BuildContext context) {
    return Consumer<AdminDashBoardProvider>(
      builder: (context, value, child) => GridView.builder(
        itemCount: value.dashboardList.length,
          shrinkWrap: true,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            return Consumer<AllDriversProvider>(
              builder: (context,drivers,child)=>GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminDashboardDriverWidget(allDrivers: drivers.allDrivers)));
                },
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.teal,
                  ),
                  child: Center(child: Text(value.dashboardList[index])),
                ),
              ),
            );
          }),
    );
  }
}
