import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users_app/authentication/signup_screen.dart';
import 'package:users_app/configuraton/configuration.dart';
import 'package:users_app/global/colors.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/splashScreen/splash_screen3.dart';
import 'package:users_app/widgets/progress_dialog.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  bool isSecure=true;


  validateForm() {
    if(emailTextEditingController.text.isEmpty && passwordTextEditingController.text.isEmpty) {
      showDialog(context: context,
        builder: (context) => AlertDialog
          (
          title: Text('Required'),
          content: Text(
              'Fields can not be empty.'
          ),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          actions: [
            TextButton(

                onPressed: () =>Navigator.pop(context) ,
                child: Text('OK'))
          ],
        ),
      );
      //  Fluttertoast.showToast(msg: "Phone Number is required.");
    }
    else if(!emailTextEditingController.text.contains("@"))
    {
      showDialog(context: context,
        builder: (context) => AlertDialog
          (
          title: Text('Invalid Email'),
          content: Text(
              'Enter Valid Email'
          ),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          actions: [
            TextButton(
                onPressed: () =>Navigator.pop(context) ,
                child: Text('OK'))

          ],
        ),
      );
      // Fluttertoast.showToast(msg: "Email address is not Valid.");
    }
    else if (passwordTextEditingController.text.isEmpty) {
      showDialog(context: context,
        builder: (context) => AlertDialog
          (
          content: Text(
              'Password Cannot be empty'
          ),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          actions: [
            TextButton(
                onPressed: () =>Navigator.pop(context) ,
                child: Text('OK'))

          ],
        ),
      );
    }
    else if (emailTextEditingController.text.isEmpty) {
      showDialog(context: context,
        builder: (context) => AlertDialog
          (
          content: Text(
              'Email Cannot be empty'
          ),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          actions: [
            TextButton(
                onPressed: () =>Navigator.pop(context) ,
                child: Text('OK'))

          ],
        ),
      );
    }else {
      loginUserNow();
    }
  }

  loginUserNow() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return ProgressDialog(
            message: "Processing, Please wait...",
          );
        });

    final User? firebaseUser = (await fAuth
        .signInWithEmailAndPassword(
      email: emailTextEditingController.text.trim(),
      password: passwordTextEditingController.text.trim(),
    )
        .catchError((msg) {
      Navigator.pop(context);
      showDialog(context: context,
        builder: (context) => AlertDialog
          (
          content: Text(
              'Incorrect Password'
          ),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          actions: [
            TextButton(
                onPressed: () =>Navigator.pop(context) ,
                child: Text('OK'))

          ],
        ),
      );
      //   Fluttertoast.showToast(msg: "Error: " + msg.toString());
    }))
        .user;

    if (firebaseUser != null) {
      DatabaseReference driversRef =
      FirebaseDatabase.instance.ref().child("users");

      driversRef.child(firebaseUser.uid).once().then((driverKey) {
        final snap = driverKey.snapshot;
        print(snap.value);
        print((snap.value as dynamic)["userType"]);
        if (snap.value != null) {
          currentFirebaseUser = firebaseUser;
          showDialog(context: context,
            builder: (context) => AlertDialog
              (
              content: Text(
                  'Login Successfully'
              ),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              actions: [
                TextButton(
                    onPressed: () =>Navigator.pop(context) ,
                    child: Text('OK'))

              ],
            ),
          );
          Navigator.push(context,
              MaterialPageRoute(builder: (c) => MySplashScreen3(userType: (snap.value as dynamic)["userType"],)));
        } else {
          showDialog(context: context,
            builder: (context) => AlertDialog
              (
              content: Text(
                  'No record with this email'
              ),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              actions: [
                TextButton(
                    onPressed: () =>Navigator.pop(context) ,
                    child: Text('OK'))

              ],
            ),
          );
          fAuth.signOut();
          Navigator.push(context,
              MaterialPageRoute(builder: (c) => MySplashScreen3(userType: (snap.value as dynamic)["userType"],)));
        }
      });
    } else {
      Navigator.pop(context);
      showDialog(context: context,
        builder: (context) => AlertDialog
          (
          content: Text(
              'Error occured during login'
          ),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          actions: [
            TextButton(
                onPressed: () =>Navigator.pop(context) ,
                child: Text('OK'))

          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ), //Padding(
              //    padding: const EdgeInsets.all(20.0),
              //  child: Image.asset("images/earn.png"),
              // ),
              SizedBox(height: 280,width:260,
                child:  Image.asset("images/earn.png"),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Login as a User",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "Email",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
              TextField(
                controller: passwordTextEditingController,
                keyboardType: TextInputType.text,
                obscureText: isSecure,

                style: const TextStyle(color: Colors.black
                ),
                decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Password",
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                    labelStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    suffixIcon:IconButton(
                      onPressed:(){
                        setState((){
                          isSecure=!isSecure;
                        });
                      },
                      icon: Icon(isSecure ? Icons.visibility_off:Icons.visibility_sharp,color: AppColors.whiteColor,),
                    )

                ),
              ),
              const SizedBox(
                height: 30,
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  child: const Text(
                    "Login",
                    style:
                    TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {
                    validateForm();
                  },
                ),
              ),
              TextButton(
                child: const Text(
                  "Do not have an Account? Register",
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => const SignUpScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
