import 'dart:async';
import 'package:flutter/material.dart';
import 'package:users_app/assistants/assistant_methods.dart';
import 'package:users_app/authentication/login_screen.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/mainScreens/main_screen.dart';
import 'package:users_app/configuraton/configuration.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:users_app/splashScreen/splash_screen3.dart';
import 'package:users_app/widgets/ui/admin/dashboard/admin_dashboard.dart';


class MySplashScreen2 extends StatefulWidget
{
  final String userType;
  MySplashScreen2({required this.userType, Key? key}) : super(key: key);

  @override
  _MySplashScreen2State createState() => _MySplashScreen2State();
}



class _MySplashScreen2State extends State<MySplashScreen2>
{

  startTimer()
  {
    print("::::: "+widget.userType);
    fAuth.currentUser != null ? AssistantMethods.readCurrentOnlineUserInfo() : null;

    Timer(const Duration(seconds: 5), () async
    {

        Navigator.push(context, MaterialPageRoute(builder: (c)=> MySplashScreen3(userType: userModelCurrentInfo?.userType??"",)));

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
        child:
        Container(color: Colors.white,
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(height: 270,width:260,
                  child:  Image.asset("images/earn.png"),
                ),
                const DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: Color(0xFF121212),
                      fontFamily: "myFont1",
                    ),
                    child: Text(
                        "Earn More"
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
                          "Want to earn more??"
                              "\n Get notified with multiple ride requests., "
                              "including permanent contractual rides.  "
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
                              decoration: BoxDecoration(color:Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: shadowList,
                              ),
                              margin: EdgeInsets.only(top: 0, left: 55),
                              child: Text(
                                " Skip",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20,
                                    color: primaryGreen
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
