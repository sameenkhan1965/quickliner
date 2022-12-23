import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:users_app/assistants/assistant_methods.dart';
import 'package:users_app/authentication/login_screen.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/mainScreens/request_screen.dart';
import 'package:users_app/widgets/my_drawer.dart';
import 'package:users_app/configuraton/configuration.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MainScreen extends StatefulWidget
{
  @override
  _MainScreenState createState() => _MainScreenState();
}




class _MainScreenState extends State<MainScreen>
{
  GlobalKey<ScaffoldState> sKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      key: sKey,
      drawer: Container(
        width: 265,
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.black,
          ),
          child: MyDrawer(
            name: userModelCurrentInfo!.name,
            email: userModelCurrentInfo!.email,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [

            //custom hamburger button for drawer
            Positioned(
              top: 40,
              left: 14,
              child: GestureDetector(
                onTap: ()
                {
                  sKey.currentState!.openDrawer();
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.menu,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text('Location'),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: primaryGreen,
                          ),
                          Text('Islamabad, Pakistan'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),




            Container(
                height: 100,
                margin: EdgeInsets.only(left: 29,right: 20, top: 150),
                child: Expanded(
                  child: Row(
                      children: [

                        GestureDetector(
                          onTap: (){
                           // Navigator.push(context, MaterialPageRoute(builder: (context)=>SoloRide()));

                          },
                          child: Container(
                            height: 65,
                            decoration: BoxDecoration(
                                color: Colors.white,

                                boxShadow: shadowList,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Expanded(
                              child: Column(
                                children: [
                                  Align(
                                    child: Image.asset('images/logo.png',height: 50,),
                                  ),
                                ],

                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>RequestScreen()));
                          },
                          child: Container(
                            height: 65,
                            margin: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: shadowList,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Expanded(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Align(
                                      child: Image.asset('images/logo.png',height: 40,),
                                    ),
                                  ),

                                ],

                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                           // Navigator.push(context, MaterialPageRoute(builder: (context)=>PermanentRequest()));
                          },
                          child: Container(
                            height: 65,
                            margin: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: shadowList,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Expanded(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Align(
                                      child: Image.asset('images/logo.png',height: 40,),
                                    ),
                                  ),

                                ],

                              ),
                            ),
                          ),
                        ),
                        GestureDetector(

                          onTap: (){
                          //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ScheduleRequest()));
                          },
                          child: Container(
                            height: 65,
                            margin: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: shadowList,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Expanded(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Align(
                                      child: Image.asset('images/logo.png',height: 40,),
                                    ),
                                  ),

                                ],

                              ),
                            ),
                          ),
                        ),
                      ]
                  ),
                )
            ),

            Container(
                height:40,
                margin: EdgeInsets.only(left: 29,right: 20, top: 260),
                child: Expanded(
                  child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                           // Navigator.push(context, MaterialPageRoute(builder: (context)=>SoloRide()));

                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Container(
                              height: 65,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  //  boxShadow: shadowList,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Expanded(
                                child: Column(
                                  children: [
                                    Text("Solo Ride")
                                  ],

                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                          //  Navigator.push(context, MaterialPageRoute(builder: (context)=>GenerateRequest()));

                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0, left: 24),
                            child: Container(
                              height: 65,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  //  boxShadow: shadowList,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Expanded(
                                child: Column(
                                  children: [
                                    Text("Generate"
                                        "\n  Request")
                                  ],

                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0, left: 24),
                          child: Container(
                            height: 65,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                //  boxShadow: shadowList,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Expanded(
                              child: Column(
                                children: [
                                  Text("Permanent"
                                      "\n  Request")
                                ],

                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0, left: 24),
                          child: Container(
                            height: 65,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                //  boxShadow: shadowList,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Expanded(
                              child: Column(
                                children: [
                                  Text("Schedule"
                                      "\n  Request")
                                ],

                              ),
                            ),
                          ),
                        ),
                      ]
                  ),
                )
            ),


            //***************** Start your journey *********************************
            SizedBox(
              height: 8,
            ),
            Row(
                children: [
                  Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 2),
                    margin: EdgeInsets.only(top: 300),
                    decoration: BoxDecoration(
                        color:Colors.greenAccent[30],
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Available Drivers', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        ),),

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 340, left: 60),
                    child: Container(
                      height: 65,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          //boxShadow: shadowList,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Expanded(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: (){
                               // Navigator.push(context, MaterialPageRoute(builder: (context)=>AvailableDrivers()));

                              },
                              child: Text("View all Broadcasts", style: TextStyle(
                                  color: primaryGreen,
                                  fontWeight: FontWeight.w600
                              ),),
                            )
                          ],

                        ),
                      ),
                    ),
                  ),
                ]
            ),

            //***************** Braodcasts *********************************
            GestureDetector(
              onTap: (){
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>Screen2()));

              },
              child: Container(
                height: 220,
                margin: EdgeInsets.only(left: 20, right: 20, top:370),
                child: Row(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            height:160,
                            decoration: BoxDecoration(color:primaryGreen,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: shadowList,
                            ),
                            margin: EdgeInsets.only(top: 20),
                          ),
                          Align(
                            child: Hero(
                                tag:1,child: Image.asset('images/carry-dabba.png')),
                          )

                        ],
                      ),
                    ),
                    Expanded(
                        child: Container(
                          padding: EdgeInsets.only(right: 30, left: 20, top: 30, bottom: 40),
                          child: Text(
                            "Abdur Rehman\n"
                                "Carry Dabba"
                                "\n(RLA-395)",
                            style: TextStyle(fontSize: 15),),
                          margin: EdgeInsets.only(top: 10,bottom: 20),
                          decoration: BoxDecoration(color: Colors.white,
                              boxShadow: shadowList,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              )
                          ),

                        )

                    )

                  ],
                ),

              ),
            ),
            Container(
              height: 220,
              margin: EdgeInsets.only(left: 20, right: 20, top:570),
              child: Row(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          height:170,
                          decoration: BoxDecoration(color:primaryGreen,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: shadowList,
                          ),
                          margin: EdgeInsets.only(top: 5),
                        ),
                        Align(
                          child: Image.asset('images/mehranimg.png'),
                        )

                      ],
                    ),
                  ),
                  Expanded(child: Container(
                    padding: EdgeInsets.only(right: 30, left: 20, top: 30, bottom: 40),
                    child: Text(
                      "Sameen Khan\n"
                          "Suzuki Mehran"
                          "\n(RUA-115)",
                      style: TextStyle(fontSize: 15),),
                    margin: EdgeInsets.only(top: 0,bottom: 20),
                    decoration: BoxDecoration(color: Colors.white,

                        boxShadow: shadowList,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20)

                        )
                    ),

                  ))

                ],
              ),

            ),
            Container(
              height: 220,
              margin: EdgeInsets.only(left: 20, right: 20, top:770),
              child: Row(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          height:170,
                          decoration: BoxDecoration(color:primaryGreen,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: shadowList,
                          ),
                          margin: EdgeInsets.only(top: 5),
                        ),
                        Align(
                          child: Image.asset('images/carry-dabba.png'),
                        )

                      ],
                    ),
                  ),
                  Expanded(child: Container(
                    padding: EdgeInsets.only(right: 30, left: 20, top: 30, bottom: 40),
                    child: Text(
                      "Ali Raza\n"
                          "Carry Dabba"
                          "\n(LIA-335)",
                      style: TextStyle(fontSize: 15),),
                    margin: EdgeInsets.only(top: 0,bottom: 20),
                    decoration: BoxDecoration(color: Colors.white,

                        boxShadow: shadowList,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20)

                        )
                    ),

                  ))

                ],
              ),

            ),


            SizedBox(height: 50,),




            Container(
              margin: EdgeInsets.only(top: 100, left: 130),
              height: 40,
              child: Text('Start Your Journey', style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
