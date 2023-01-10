import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:users_app/models/user_model.dart';

import '../models/direction_details_info.dart';



final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
UserModel? userModelCurrentInfo;
List dList = []; //this is online driver's list containing their key info
DirectionDetailsInfo? tripDirectionDetailsInfo;
String? chosenDriverId=""; // jis ko ride notification jaye gi
String cloudMessagingServerToken = "key=AAAAWodSwuk:APA91bGH7m8ayPAEvoOTxO983vjRLl-PHBqvnT6S5SMmoRsbH4FZvq900HeLXkI2fG7DkY6V-5Y9CbTW6IzqZbNP-I5yHBXIg4vbbAejz_RJp093NNaMwjapJV3gZd-Jsm35fnW0EV0q";
String userDropOffAddress = "";
String driverCarDetails="";
String driverName="";
String driverPhone="";
double countRatingStars=0.0;
String titleStarsRating="";

double getHeight(BuildContext context)
{
  return MediaQuery.of(context).size.height;
}

double getWidth(BuildContext context)
{
  return MediaQuery.of(context).size.width;
}

BoxDecoration backGroundImage()
{
  return const BoxDecoration(
    image: DecorationImage(
      opacity: 0.3,
      image: AssetImage('images/logo.png'),
    ),
  );
}

showProgressPar({required BuildContext context})
{
  showDialog(context: context, builder: (context){
    return Stack(
      children: [
        AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(""),
              Text("LOADING"),
            ],
          ),
        ),
      ],
    );
  });
}
