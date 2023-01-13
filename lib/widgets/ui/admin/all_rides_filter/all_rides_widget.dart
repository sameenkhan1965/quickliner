import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users_app/global/colors.dart';
import 'package:users_app/global/global.dart';
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
          backgroundColor: Colors.teal,
          body: Column(
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
                                                                "Rides",
                                                                style: TextStyle(
                                                                    color: Colors.black,
                                                                    fontWeight: FontWeight.normal,
                                                                    fontSize: 30),
                                                              ),
                          ],
                        )),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(60),
                                          topRight: Radius.circular(60))),
                  child: Padding(
                    padding: EdgeInsets.only(top:10.0),
                    child: SizedBox(
                       width: MediaQuery.of(context).size.width,
                                          height:
                                              MediaQuery.of(context).size.height * 0.65,
                      child: Column(
                        children: [
                         
                          Expanded(
                            child: Consumer<AllRidesWigetProvider>(
                          builder: (context,allRide,child)=>
                          
                                
                                   ListView.separated(
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
                                  )
                               
                                
              
                              
                            ),
                          ),
                        
                        
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget getRideContainer(TripsHistoryModel tripsHistoryModel) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>RideDetail(tripsHistoryModel: tripsHistoryModel,)));
      },
      child: Container(
        
        margin: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 2.0,
        ),
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primaryColor,
          ),
          borderRadius: BorderRadius.circular(10.0),
          // color: tripsHistoryModel.rideTyp,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(title),
    );
  }
}
