import 'dart:async';
import 'package:flutter/material.dart';
import 'package:users_app/assistants/assistant_methods.dart';
import 'package:users_app/authentication/login_screen.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/mainScreens/main_screen.dart';
import 'package:users_app/configuraton/configuration.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:users_app/splashScreen/splash_screen2.dart';
import 'package:users_app/widgets/ui/admin/dashboard/admin_dashboard.dart';


class MySplashScreen extends StatefulWidget
{
     final String userType;
     MySplashScreen({required this.userType, Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}



class _MySplashScreenState extends State<MySplashScreen>
{

  startTimer()
  {
    print("::::: "+widget.userType);
    fAuth.currentUser != null ? AssistantMethods.readCurrentOnlineUserInfo() : null;

    Timer(const Duration(seconds: 7), () async
    {

        Navigator.push(context, MaterialPageRoute(builder: (c)=> MySplashScreen2(userType: userModelCurrentInfo?.userType??"",)));

    });
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context)
  {
    return Material(
      child: Container(
        color: primaryGreen,
        child: Center(


            child: Container(color: Colors.white,
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("QuickLiner",style: TextStyle(
                    color: primaryGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ), ),
                  SizedBox(height: 260,width:260,
                      child:  Image.asset("images/time.png"),
                  ),
                  const DefaultTextStyle(
                      style: TextStyle(
                        fontSize: 19.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        color: Color(0xFF121212),
                        fontFamily: "myFont1",
                      ),
                      child:  Text(
                          "Make your lives easy"
                      )
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: const DefaultTextStyle(
                        style: TextStyle(
                          fontSize: 14.0,
                          //fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                          color: Color(0xFF121212),
                          fontFamily: "myFont2",
                        ),
                        textAlign: TextAlign.center,
                        child: Text(
                            "Book rides based on your availability and choice."
                                "  Schedule a ride or book a permanent ride anywhere anytime "
                        )

                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                    },
                    child: Container(
                      height: 120,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          //  Expanded(
                          Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10.0),
                                height:50,
                                width: 260,
                                decoration: BoxDecoration(color:primaryGreen,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: shadowList,
                                ),
                                margin: EdgeInsets.only(top: 0, left: 55),
                                child: Text(
                                  " Skip",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],

                      ),
                    ),
                  )
                ],
              ),


            ),
          ),
        ),
      );

  }
}
