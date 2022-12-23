import 'package:firebase_auth/firebase_auth.dart';
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