import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users_app/assistants/request_assistant.dart';
import 'package:users_app/global/colors.dart';
import 'package:users_app/global/map_key.dart';
import 'package:users_app/infoHandler/app_info.dart';
import 'package:users_app/models/directions.dart';
import 'package:users_app/models/predicted_places.dart';
import 'package:users_app/widgets/progress_dialog.dart';


class PlacePredictionTileDesign extends StatelessWidget
{
  final PredictedPlaces? predictedPlaces;

  PlacePredictionTileDesign({this.predictedPlaces});


  getPlaceDirectionDetails(String? placeId, context) async
  {
    showDialog(
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        message: "Setting Up Drof-Off, Please wait...",
      ),
    );

    String placeDirectionDetailsUrl = "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$mapKey";

    var responseApi = await RequestAssistant.receiveRequest(placeDirectionDetailsUrl);

    Navigator.pop(context);

    if(responseApi == "Error Occurred, Failed. No Response.")
    {
      return;
    }

    if(responseApi["status"] == "OK")
    {
      Directions directions = Directions();
      directions.locationName = responseApi["result"]["name"];
      directions.locationId = placeId;
      directions.locationLatitude = responseApi["result"]["geometry"]["location"]["lat"];
      directions.locationLongitude = responseApi["result"]["geometry"]["location"]["lng"];

      Provider.of<AppInfo>(context, listen: false).updateDropOffLocationAddress(directions);

      Navigator.pop(context, "obtainedDropoff");
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return ElevatedButton(
      onPressed: ()
      {
        getPlaceDirectionDetails(predictedPlaces!.place_id, context);
      },
      style: ElevatedButton.styleFrom(
        primary: AppColors.whiteColor,
      ),
      child: Card(
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(
                Icons.add_location,
                color: AppColors.blackColor,
              ),
              const SizedBox(width: 14.0,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8.0,),
                    Text(
                      predictedPlaces!.main_text!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color:AppColors.blackColor,
                      ),
                    ),
                    const SizedBox(height: 2.0,),
                    Text(
                      predictedPlaces!.secondary_text!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: AppColors.blackColor,
                      ),
                    ),
                    const SizedBox(height: 8.0,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
