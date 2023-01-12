import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/models/user_model.dart';


class Rider extends StatefulWidget {
  final List<UserModel> allrider;
   Rider({super.key, required this.allrider});

  @override
  State<Rider> createState() => _RiderState();
}

class _RiderState extends State<Rider> {
UserModel? userModelCurrentInfo;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Query dbRef = FirebaseDatabase.instance.ref().child('users');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('users');
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:  Colors.teal,
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(onPressed: (){
                              Navigator.pop(context);
                            }, icon: Icon(Icons.arrow_back)),
                            SizedBox(width: getWidth(context)*0.25,),
                        Text(
                          "Rider",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 30),
                        )
                      ],
                    )),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Container(
                    // height: MediaQuery.of(con/text).size.height * 0.50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60))),
                    child: Padding(
                        padding: EdgeInsets.all(getHeight(context)*0.114),
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                          children: [
                        getAllCustomer()
                          ])
  
                    
          ))])));
  }
  
  getAllCustomer() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.allrider.length,
        physics: const ScrollPhysics(
          parent: ScrollPhysics(),
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>
              // DashboardDriverDetailWidget(
              //   driverData: widget.allDrivers[index],)));
            },
            child: getCustomersRow(
                name:userModelCurrentInfo?.name?? "",
                email: widget.allrider[index].email ?? "",
                phone: widget.allrider[index].phone ?? "",
                userType: widget.allrider[index].userType ?? "",
                
          ));
        });
  }
  Widget getCustomersRow(
      {required String name,
      required String email,
      required String phone,
      required String userType,}){
        return Expanded(
           flex: 2,
           child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.only(
                                   topLeft: Radius.circular(60),
                                   topRight: Radius.circular(60))),
             child: Column(
               mainAxisSize: MainAxisSize.min,
               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     const Text(
                       "Rider Name",
                       style: TextStyle(fontWeight: FontWeight.bold),
                     ),
                     Text(name, 
                     style: GoogleFonts.poppins(
                      color: Colors.black
                     ),
                     ),
                   ],
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     const Text(
                       "Email",
                       style: TextStyle(fontWeight: FontWeight.bold),
                     ),
                     Text(email),
                   ],
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     const Text(
                       "Phone",
                       style: TextStyle(fontWeight: FontWeight.bold),
                     ),
                     Text(phone),
                   ],
                 ),
               ],
             ),
           ),
         );
      }
  }
           