import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/widgets/info_design_ui.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  bool isEdit=false;
  TextEditingController phoneController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //name
            Text(
              userModelCurrentInfo?.name!??"Admin",
              style: const TextStyle(
                fontSize: 50.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 20,
              width: 200,
              child: Divider(
                color: Colors.white,
                height: 2,
                thickness: 2,
              ),
            ),

            const SizedBox(
              height: 38.0,
            ),

            //phone
            isEdit==false? InfoDesignUIWidget(
              textInfo: userModelCurrentInfo?.phone!??"",
              iconData: Icons.phone_iphone,
            ):Card(
              color: Colors.white54,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  hintText: "Phone Number",
                  border: InputBorder.none,focusedBorder: InputBorder.none
                ),
              )),

            //email
           isEdit==false? InfoDesignUIWidget(
              textInfo: userModelCurrentInfo?.email!??"",
              iconData: Icons.email,
            ):Card(
              color: Colors.white54,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: InputBorder.none,focusedBorder: InputBorder.none
                  ),
                ),
            ),

            const SizedBox(
              height: 20,
            ),

            ElevatedButton(
              onPressed: () {
                // SystemNavigator.pop();
                // Navigator.pop(context);
                setState(() {
                  isEdit = true;
                });
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white54,
              ),
              child: const Text(
                "Edit",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () async{
                // SystemNavigator.pop();
                // Navigator.pop(context);
                // setState(() {
                //   isEdit = true;
                // });

                DatabaseReference ref = FirebaseDatabase.instance.ref("users/0VjuccLQB6R50vy0DhjVPK7Pi0w1");
                await ref.update({
                "phone": phoneController.text,
                "email":emailController.text

                });

                setState(() {
                  isEdit=false;
                });
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white54,
              ),
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
