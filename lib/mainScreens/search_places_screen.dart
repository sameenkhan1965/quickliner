import 'package:flutter/material.dart';
import 'package:users_app/assistants/request_assistant.dart';
import 'package:users_app/global/colors.dart';
import 'package:users_app/global/map_key.dart';
import 'package:users_app/models/predicted_places.dart';
import 'package:users_app/widgets/place_prediction_tile.dart';


class SearchPlacesScreen extends StatefulWidget
{

  @override
  _SearchPlacesScreenState createState() => _SearchPlacesScreenState();
}




class _SearchPlacesScreenState extends State<SearchPlacesScreen>
{
  List<PredictedPlaces> placesPredictedList = [];

  void findPlaceAutoCompleteSearch(String inputText) async
  {
    if(inputText.length > 1) //2 or more than 2 input characters
        {
      String urlAutoCompleteSearch = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$inputText&key=$mapKey&components=country:PK";

      var responseAutoCompleteSearch = await RequestAssistant.receiveRequest(urlAutoCompleteSearch);

      if(responseAutoCompleteSearch == "Error Occurred, Failed. No Response.")
      {
        return;
      }

      if(responseAutoCompleteSearch["status"] == "OK")
      {
        var placePredictions = responseAutoCompleteSearch["predictions"];

        var placePredictionsList = (placePredictions as List).map((jsonData) => PredictedPlaces.fromJson(jsonData)).toList();

        setState(() {
          placesPredictedList = placePredictionsList;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context)
  {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title:const Text(
          "Search & Set DropOff Location",
          style: TextStyle(
            fontSize: 16.0,
            color: AppColors.whiteColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// search place ui
            Container(
              height: size.height*0.1,
              child: Padding(
                padding:  EdgeInsets.only(left: 25.0,right: 25,top: size.height*0.020),
                child:Container(
                  height: 40,
                  child: TextFormField(
                    onChanged: (valueTyped)
                    {
                      findPlaceAutoCompleteSearch(valueTyped);
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search,color: AppColors.blackColor,),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder:  OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border:  OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        // label: Text("Search Brodcast"),
                        hintText: 'Search here',
                        hintStyle:TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade500
                        )
                    ),
                  ),
                )
              ),
            ),

            //display place predictions result
            (placesPredictedList.length > 0)
                ? ListView.builder(
                  itemCount: placesPredictedList.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index)
                  {
                    return PlacePredictionTileDesign(
                      predictedPlaces: placesPredictedList[index],
                    );
                  },
                  // separatorBuilder: (BuildContext context, int index)
                  // {
                  //   return const Divider(
                  //     height: 1,
                  //     color: AppColors.primaryColor,
                  //     thickness: 1,
                  //   );
                  // },
                )
                : Container(),
          ],
        ),
      ),
    );
  }
}
