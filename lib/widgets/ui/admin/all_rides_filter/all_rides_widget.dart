import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users_app/global/colors.dart';
import 'package:users_app/models/trips_history_model.dart';
import 'package:users_app/widgets/providers/admin/all_rides_widget_provider.dart';
import 'package:users_app/widgets/ui/admin/all_rides_filter/ride_detail.dart';

class AllRidesWidget extends StatefulWidget {
  const AllRidesWidget({Key? key}) : super(key: key);

  @override
  State<AllRidesWidget> createState() => _AllRidesWidgetState();
}

class _AllRidesWidgetState extends State<AllRidesWidget>
    with TickerProviderStateMixin {
  late TabController tabController;
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    Provider.of<AllRidesWigetProvider>(context, listen: false)
        .getAllRides(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("All Rides"),
          ),
          body: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Consumer<AllRidesWigetProvider>(
                  builder: (context, tabs, child) => TabBar(
                      controller: tabController,
                      isScrollable: true,
                      tabs: [
                        ...List.generate(tabs.tabBar.length, (index) {
                          return getTabView(tabs.tabBar[index]);
                        }),
                      ]),
                ),
                Expanded(
                  child: Consumer<AllRidesWigetProvider>(
                builder: (context,allRide,child)=>TabBarView(controller: tabController, children: [
                      ...List.generate(allRide.tabBar.length, (index) {
                        return ListView.separated(
                          shrinkWrap: true,
                          itemCount: allRide.allRides.length,
                          itemBuilder: (context, index) {
                            print(allRide.allRides[index].rideType);
                            return getRideContainer(allRide.allRides[index]);
                            // return Text(allRides.allRides[index].rideType??"",style: TextStyle(color: Colors.black),);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(
                              thickness: 2.0,
                              endIndent: 10.0,
                              indent: 10.0,
                            );
                          },
                        );
                      }),

                    ]),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget getRideContainer(TripsHistoryModel tripsHistoryModel) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>RideDetail(tripsHistoryModel: tripsHistoryModel,)));
      },
      child: Container(
        foregroundDecoration: BoxDecoration(
          image: DecorationImage(
            opacity: 0.2,
            image:  AssetImage("images/logo.png"),

          ),
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 2.0,
        ),
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors().primaryColor,
          ),
          borderRadius: BorderRadius.circular(10.0),
          // color: tripsHistoryModel.rideTyp,
        ),
        child: Column(
          children: [
            Text(tripsHistoryModel.rideType ?? ""),
            Text(tripsHistoryModel.status ?? ""),
            Text(tripsHistoryModel.originAddress ?? ""),
            Text(tripsHistoryModel.destinationAddress ?? ""),
          ],
        ),
      ),
    );
  }

  Widget getTabView(String title) {
    return Container(

      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: AppColors().primaryColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(title),
    );
  }
}
