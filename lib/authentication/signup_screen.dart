import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users_app/authentication/login_screen.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/splashScreen/splash_screen3.dart';
import 'package:users_app/widgets/progress_dialog.dart';


class SignUpScreen extends StatefulWidget
{
  const SignUpScreen({super.key});


  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}
class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  validateForm()
  {
    if(nameTextEditingController.text.isEmpty && emailTextEditingController.text.isEmpty && phoneTextEditingController.text.isEmpty && passwordTextEditingController.text.isEmpty) {
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
    else if(nameTextEditingController.text.isEmpty)
    {
      showDialog(context: context,
        builder: (context) => AlertDialog
          (
          title: Text('Required'),
          content: Text(
              'Name can not be empty.'
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
    else if(nameTextEditingController.text.length < 4)
    {
          showDialog(context: context,
          builder: (context) => AlertDialog(
          content: Text(
          'Name must be atleast of 4 characters.'),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(30),
          ),
          actions: [
          TextButton(
          onPressed: () =>Navigator.pop(context) ,
          child: Text('OK'))
          ],
          ),
    );
    }
    /* if(nameTextEditingController!=RegExp(r"[A-Za-z]"))
    {
          showDialog(context: context,
          builder: (context) => AlertDialog(
          content: Text(
          'Name Can only be Alphabets'),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          ),
          actions: [
          TextButton(
          onPressed: () =>Navigator.pop(context) ,
          child: Text('OK'))
          ],
          ),
    );
    }
   else if(nameTextEditingController.text.isNotEmpty || emailTextEditingController.text.isEmpty)
    {
      showDialog(context: context,
        builder: (context) => AlertDialog
          (
          title: Text('Required'),
          content: Text(
              'Email can not be empty.'
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

*/


    else if(emailTextEditingController.text.isEmpty)
    {
      showDialog(context: context,
        builder: (context) => AlertDialog
          (
          title: Text('Required'),
          content: Text(
              'Email can not be empty.'
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

    else if(phoneTextEditingController.text.isEmpty)
    {
      showDialog(context: context,
        builder: (context) => AlertDialog
          (
          title: Text('Required'),
          content: Text(
              'Phone number can not be empty.'
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
    else if(passwordTextEditingController.text.isEmpty)
    {
      showDialog(context: context,
        builder: (context) => AlertDialog
          (
          title: Text('Required'),
          content: Text(
              'Password can not be empty.'
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
   /* else if(passwordTextEditingController != RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'))
    {
      showDialog(context: context,
        builder: (context) => AlertDialog
          (
          title: Text('Required'),
          content: Text(
              'Password should be of 8 character that contain at least one Upper case, one lower, one digit & one special character.'
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
    */ //}
     //}
    else
    {
      saveUserInfoNow();
    }
  }

  saveUserInfoNow() async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c)
        {
          return ProgressDialog(message: "Processing, Please wait...",);
        }
    );

    final User? firebaseUser = (
        await fAuth.createUserWithEmailAndPassword(
          email: emailTextEditingController.text.trim(),
          password: passwordTextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error: " + msg.toString());
        })
    ).user;

    if(firebaseUser != null)
    {
      Map userMap =
      {
        "id": firebaseUser.uid,
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
        "userType":"customer",
      };

      DatabaseReference reference = FirebaseDatabase.instance.ref().child("users");
      reference.child(firebaseUser.uid).set(userMap);

      currentFirebaseUser = firebaseUser;

      Fluttertoast.showToast(msg: "Account has been Created.");
      showDialog(context: context,
        builder: (context) => AlertDialog
          (
          title: Text('Required'),
          content: Text(
              'Account has not been Created.'
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

      Navigator.push(context, MaterialPageRoute(builder: (c)=> MySplashScreen3(userType: "customer",)));
    }
    else
    {
      showDialog(context: context,
        builder: (context) => AlertDialog
          (
          title: Text('Required'),
          content: Text(
              'Account has not been Created.'
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
     // Navigator.pop(context);
      //Fluttertoast.showToast(msg: "Account has not been Created.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [

              const SizedBox(height: 5,),

              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Image.asset("images/Order ride.png"),
              ),

              const SizedBox(height: 10,),

              const Text(
                "Register Yourself",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              TextField(
                controller: nameTextEditingController,
                style: const TextStyle(
                    color: Colors.grey
                ),
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  hintText: "Enter your Name",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),

              TextField(
                controller: emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                    color: Colors.grey
                ),
                decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "Email",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),

              TextField(
                controller: phoneTextEditingController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(
                    color: Colors.grey
                ),
                decoration: const InputDecoration(
                  labelText: "Phone",
                  hintText: "Phone",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),

              TextField(
                controller: passwordTextEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                style: const TextStyle(
                    color: Colors.grey
                ),
                decoration: const InputDecoration(
                  labelText: "Password",
                  hintText: "Password",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
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
                    "Register",
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
                  "Already have an Account? Login Now",
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
