import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class Permanent extends StatefulWidget {
  const Permanent({super.key});

  @override
  State<Permanent> createState() => _PermanentState();
}

class _PermanentState extends State<Permanent> {

  var totalPrice, moneyperDay=250, days;
  TextEditingController daysController=TextEditingController();
 

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
                                                borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(50),
                                                    topRight:
                                                        Radius.circular(50),
                                                  )
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
                                                      
                                                      controller: daysController,
                                                      keyboardType: TextInputType.number,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Days",
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
                                                      days= int.parse(daysController.text);
                                                     
                                                      totalPrice= moneyperDay*days;
                                                      print("Total: $totalPrice");
                                                   
                                                      Map fareMap =
      {
        "fare_type":"permanent",
        "money_per_day": moneyperDay,
        "days":daysController.text,
        "permanent_money": totalPrice,
       };

      DatabaseReference reference = FirebaseDatabase.instance.ref().
      child("Fare").ref.child('Permanent');
      reference..set(fareMap);
         setState(() {
                               
                             });       
                                                           // Navigator.push(context,
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