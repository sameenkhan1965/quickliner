import 'package:flutter/material.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/models/user_model.dart';
import 'package:users_app/splashScreen/splash_screen.dart';

import '../about/about_screen.dart';
import '../global/colors.dart';
import '../mainScreens/profile_screen.dart';
import '../mainScreens/trips_history_screen.dart';


class MyDrawer extends StatefulWidget
{
  String? name;
  String? email;

  MyDrawer({this.name, this.email});

  @override
  _MyDrawerState createState() => _MyDrawerState();
}



class _MyDrawerState extends State<MyDrawer>
{
  @override
  Widget build(BuildContext context)
  {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: AppColors.primaryColor,
      child: ListView(
        children: [
          ///drawer header
          Container(
            height: 165,
            color: AppColors.primaryColor,
            child: DrawerHeader(

              decoration: const BoxDecoration(color: AppColors.primaryColor),
              child: Row(
                children: [

                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(100)
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),


                  const SizedBox(width: 16,),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        widget.email.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const  SizedBox(height: 12.0,),
          Container(
            height:size.height ,
            color: AppColors.whiteColor,
            child: Column(
              children: [
                SizedBox(height: size.height*0.05,),
                /// drawer body
                GestureDetector(
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> TripsHistoryScreen()));
                  },
                  child: const ListTile(
                    leading: Icon(Icons.history, color:AppColors.primaryColor),
                    title: Text(
                      "History",
                      style: TextStyle(
                          color: AppColors.blackColor
                      ),
                    ),
                  ),
                ),
                const Divider(
                   color: AppColors.primaryColor,
                  endIndent: 20,
                  indent: 20,
                  thickness: 0.8,
                ),
                GestureDetector(
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> ProfileScreen()));
                  },
                  child: const ListTile(
                    leading: Icon(Icons.person, color: AppColors.primaryColor),
                    title: Text(
                      "Visit Profile",
                      style: TextStyle(
                          color: AppColors.blackColor
                      ),
                    ),
                  ),
                ),
                const Divider(
                  color: AppColors.primaryColor,
                  endIndent: 20,
                  indent: 20,
                  thickness: 0.8,
                ),
                GestureDetector(
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> AboutScreen()));
                  },
                  child: const ListTile(
                    leading: Icon(Icons.info, color: AppColors.primaryColor),
                    title: Text(
                      "About",
                      style: TextStyle(
                          color:AppColors.blackColor
                      ),
                    ),
                  ),
                ),
                const Divider(
                  color: AppColors.primaryColor,
                  endIndent: 20,
                  indent: 20,
                  thickness: 0.8,
                ),
                GestureDetector(
                  onTap: ()
                  {
                    fAuth.signOut();
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> MySplashScreen(userType: userModelCurrentInfo!.userType??"",)));
                  },
                  child: const ListTile(
                    leading: Icon(Icons.logout, color:AppColors.primaryColor),
                    title: Text(
                      "Sign Out",
                      style: TextStyle(
                          color: AppColors.blackColor
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )


        ],
      ),
    );
  }
}
