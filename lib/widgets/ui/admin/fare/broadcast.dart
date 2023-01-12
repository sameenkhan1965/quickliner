import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:users_app/global/global.dart';

class BroadcastFare extends StatefulWidget {
  const BroadcastFare({super.key});

  @override
  State<BroadcastFare> createState() => _BroadcastFareState();
}

class _BroadcastFareState extends State<BroadcastFare> {

  var totalPrice, money, petrol, distance,noOfSeats, percent, discount;
  TextEditingController petrolPrice=TextEditingController();
  TextEditingController moneyPerKM=TextEditingController();
  TextEditingController distancePerkm=TextEditingController();
  TextEditingController noofSeatsController=TextEditingController();

  @override
  Widget build(BuildContext context) {
   return SafeArea(
      child: Scaffold(
          body: Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.teal),
              child: Column(
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
                            SizedBox(width: getWidth(context)*0.15,),
                            Text(
                              "BroadCast Fare",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 30),
                            )
                          ],
                        )),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Expanded(
                        child: Container(
                            // height: MediaQuery.of(con/text).size.height * 0.50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(60),
                                    topRight: Radius.circular(60))),
                            child: Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.65,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.95,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.10,
                                              decoration: BoxDecoration(
                                                  color: Colors.teal,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(50),
                                                    topRight:
                                                        Radius.circular(50),
                                                  )),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  // mainAxisAlignment:
                                                  //     MainAxisAlignment
                                                  //         .spaceAround,
                                                  children: [
                                                    
                                                    Container(
                                                      height: 100,
                                                      width: 150,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(top:18.0),
                                                        child: TextFormField(
                                                          controller: petrolPrice,
                                                            keyboardType: TextInputType.number,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText: "Enter petrol Price",
                                                              border: InputBorder.none
                                                            
                                                            
                                                            ),
                                                            onEditingComplete: () => petrol=petrolPrice.text as int,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight.bold,
                                                                fontSize: 18),
                                                          ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            
                                            
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.95,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.10,
                                              decoration: BoxDecoration(
                                                color: Colors.amberAccent,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  width:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.3,
                                                  height:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.08,
                                                  child: TextFormField(
                                                    
                                                    controller: moneyPerKM,
                                                    onEditingComplete: () => money=moneyPerKM.text as int,
                                                    keyboardType: TextInputType.number,
                                                    decoration:
                                                        InputDecoration(
                                                      hintText: "Enter Money/km",
                                                      border: InputBorder.none
                                                    
                                                    
                                                    ),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                
                                                
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10,),
                                            Container(
                                              color: Colors.grey,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                             0.95,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.08,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: TextFormField(
                                                        
                                                        keyboardType: TextInputType.number,
                                                        controller: distancePerkm,
                                                        
                                                        decoration:
                                                            InputDecoration(
                                                          hintText: "Enter Distance",
                                                          border: InputBorder.none
                                                        
                                                        
                                                        ),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                  ),
                                                 
                                                 
                                                  SizedBox(height: 10,),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.95,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.10,
                                              decoration: BoxDecoration(
                                                  color: Colors.teal,
                                                  // borderRadius:
                                                  //     BorderRadius.only(
                                                  //   topLeft:
                                                  //       Radius.circular(50),
                                                  //   topRight:
                                                  //       Radius.circular(50),
                                                  // )
                                                  ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(left:8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                   
                                                    Container(
                                                      height: 100,
                                                      width: 150,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(top:18.0),
                                                        child: TextFormField(
                                                          controller: noofSeatsController,
                                                            keyboardType: TextInputType.number,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText: "Enter No of Seats",
                                                              border: InputBorder.none
                                                            
                                                            
                                                            ),
                                                            // onEditingComplete: () => petrol=petrolPrice.text as int,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight.bold,
                                                                fontSize: 18),
                                                          ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      
                                                      onPressed: (){
                                                        
                                                        distance= int.parse(distancePerkm.text);
                                                        petrol= int.parse(petrolPrice.text);
                                                        money=int.parse(moneyPerKM.text);
                                                        noOfSeats=int.parse(noofSeatsController.text);
                                                        percent= (noOfSeats/100);
                                                        print("percent $percent");
                                                        totalPrice= money*petrol*distance*percent;
                                                        print("Total: $totalPrice");
User? firebaseUser;

                                                        Map fareMap =
      {
        "id":firebaseUser?.uid,
        "fare_type":"broadcast",
        "distance": distancePerkm.text.trim(),
        "petrol_price": petrolPrice.text.trim(),
        "money_per_km": moneyPerKM.text.trim(),
        "no_of_seats":noofSeatsController.text.trim(),
        "discount":discount,
        "total_price":totalPrice

      };

      DatabaseReference reference = FirebaseDatabase.instance.ref().
      child("Fare").ref.child('BroadCast');
      reference.set(fareMap);
         setState(() {
                               
                             }); 
                                                             // Navigator.push(context,
                                                      //  MaterialPageRoute(builder: ((context) => 
                                                      //  BroadcastFare())));

                                                    }, icon: Icon(Icons.send))
                                                   
                                                    
                                                  ],
                                                ),
                                              ),
                                            ),
                                              SizedBox(height: 20,),
                                            Container(
         
            width: MediaQuery.of(context).size.width * 0.35,
          height: MediaQuery.of(context).size.height * 0.18,
        decoration:
             BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(35)),
          
          child: Center(
            
            child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Total Price",
                style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700
              ),
              ),
              Text(totalPrice.toString(),
                style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700
              )
              ),
             
            ],
          )),
        ),
      
      
                                            
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ))))
                  ]))),
    );
  
  
  }
}