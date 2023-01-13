import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users_app/widgets/ui/customer/permanant_ride/permanent_ride.dart';
import 'package:users_app/widgets/ui/customer/permanant_ride/permanent_rides.dart';

import '../../../../global/colors.dart';
import '../../../providers/permanentProvider.dart';
class PermanentRideMain extends StatefulWidget {
  const PermanentRideMain({Key? key}) : super(key: key);

  @override
  State<PermanentRideMain> createState() => _PermanentRideMainState();
}

class _PermanentRideMainState extends State<PermanentRideMain> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<PermanentRideProvider>(context, listen: false)
        .getScheduleRide(context);
  }
  var add=false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text("Permanent Ride",style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700
        ),
        ),
        elevation: 0,
      ),
      body:Consumer<PermanentRideProvider>(
          builder: (context, permanentRide, value) {
          return add?PermanentWidget():PermanentRidesTabPage(scheduleTrip: permanentRide.PermanentRideList,chat: false);
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},

        child:  Container(
          height: 50,
          width: 300,
          child: IconButton(
            icon: add?Icon(Icons.clear):Icon(Icons.add),
            onPressed: () {
              setState(() {
                add=!add;
              });
            },
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                primary: Colors.white,
                textStyle:   TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 15, fontWeight: FontWeight.bold)),

          ),
        ),
      ),
    );
  }
}
