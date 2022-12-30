import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users_app/infoHandler/app_info.dart';
import 'package:users_app/widgets/history_design_ui.dart';
import 'package:users_app/widgets/providers/car_pool_widget_controller.dart';

class CarPoolAlreadyRides extends StatefulWidget {
  const CarPoolAlreadyRides({Key? key}) : super(key: key);

  @override
  State<CarPoolAlreadyRides> createState() => _CarPoolAlreadyRidesState();
}

class _CarPoolAlreadyRidesState extends State<CarPoolAlreadyRides> {

  @override
  void initState()
  {
    Provider.of<CarPoolWidgetController>(context,listen: false).getAllRides(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("Car Pool Rides"),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Consumer<CarPoolWidgetController>(
          builder: (context,value,child)=>value.rides.isNotEmpty? ListView.separated(
            separatorBuilder: (context, i) => const Divider(
              color: Colors.grey,
              thickness: 2,
              height: 2,
            ),
            itemBuilder: (context, i) {
              return Card(
                color: Colors.white54,
                child: HistoryDesignUIWidget(
                  tripsHistoryModel: value.rides[i],
                ),
              );
            },
            itemCount: value.rides.length,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
          ):Text("At this moment no active ride"),
        ),
      ),
    );
  }
}
