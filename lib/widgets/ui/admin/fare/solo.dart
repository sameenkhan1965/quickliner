import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class FareWidgets extends StatefulWidget {
  const FareWidgets({super.key});

  @override
  State<FareWidgets> createState() => _FareWidgetsState();
}

class _FareWidgetsState extends State<FareWidgets> {

  var totalPrice=0, money=0, petrol=0, distance=0;
  TextEditingController petrolPrice=TextEditingController();
  TextEditingController moneyPerKM=TextEditingController();
  TextEditingController distancePerkm=TextEditingController();

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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Fare",
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
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    "Petrol Price",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
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
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.29,
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
                                                        hintText: "Money Per km",
                                                        border: InputBorder.none
                                                      
                                                      
                                                      ),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                  
                                                  
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.29,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.08,
                                                    child: TextFormField(
                                                      
                                                      keyboardType: TextInputType.number,
                                                      controller: distancePerkm,
                                                      
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Distance",
                                                        border: InputBorder.none
                                                      
                                                      
                                                      ),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                 
                                                 
                                                  IconButton(
                                                    
                                                    onPressed: (){
                                                      
                                                      distance= int.parse(distancePerkm.text);
                                                      petrol= int.parse(petrolPrice.text);
                                                      money=int.parse(moneyPerKM.text);
                                                      totalPrice= money*petrol*distance;
                                                      print("Total: $totalPrice");
User? firebaseUser;

                                                      Map fareMap =
      {
        "id":firebaseUser?.uid,
        "fare_type":"solo",
        "distance": distancePerkm.text.trim(),
        "petrol_price": petrolPrice.text.trim(),
        "money_per_km": moneyPerKM.text.trim(),
        "total_price":totalPrice

      };

      DatabaseReference reference = FirebaseDatabase.instance.ref().
      child("Fare").ref.child('Solo');
      reference.set(fareMap);
                               setState(() {
                                 
                               });                            // Navigator.push(context,
                                                    //  MaterialPageRoute(builder: ((context) => 
                                                    //  FareWidgets())));

                                                  }, icon: Icon(Icons.send))
                                                 
                                                  
                                                ],
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