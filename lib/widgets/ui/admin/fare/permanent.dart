import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../global/global.dart';

class Permanent extends StatefulWidget {
  const Permanent({super.key});

  @override
  State<Permanent> createState() => _PermanentState();
}

class _PermanentState extends State<Permanent> {

  var totalPrice=0, moneyperDay=0, days=0,petrol=0;
  TextEditingController moneyPerday=TextEditingController();
  TextEditingController daysController=TextEditingController();
  TextEditingController petrolPrice=TextEditingController();
 

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
                                padding: EdgeInsets.only(top: getHeight(context)*0.1),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.65,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                              "Permanent Fare",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 30),
                            ),
                            SizedBox(height: 30,),
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
                                            padding: const EdgeInsets.all(12.0),
                                            child: SizedBox(
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
                                                
                                                controller: moneyPerday,
                                                keyboardType: TextInputType.number,
                                                decoration:
                                                    InputDecoration(
                                                  hintText: "Money Per Day",
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

                                          SizedBox(height: 20,),
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
                                            
                                            ),
                                        child: Container(
                                          height: 100,
                                          width: 150,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top:18.0, left: 10),
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
                                          ),
                                          SizedBox(height: getHeight(context)*0.01,),
                                          ElevatedButton(
                                                child: Text("Add"),
                                                onPressed: (){
                                                  if( petrolPrice.text.isEmpty&& moneyPerday.text.isEmpty){
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

      );}
      else{
                                                  moneyperDay= int.parse(moneyPerday.text);
                                                  petrol=int.parse(petrolPrice.text);
                                                  totalPrice= moneyperDay*petrol;
                                                  print("Total: $totalPrice");
                                               
                                                  Map fareMap =
      {
        "fare_type":"permanent",
        "money_per_day": moneyPerday,
        "petrol_price":petrolPrice.text,
        "permanent_money": totalPrice,
       };

      DatabaseReference reference = FirebaseDatabase.instance.ref().
      child("Fare").ref.child('Permanent');
      // ignore: avoid_single_cascade_in_expression_statements
      reference..set(fareMap).then((value){
                                            return 
                                            showDialog(context: context, builder: (context){
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                                ),
                                                title: Text("Successfully Added Solo Fare"),
                                                actions: [
                                                  Center(child: ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text("OK")))
                                                ],
                                              );
                                            });
                                          });
         setState(() {
                               
                             }); 
      }      
                                                       // Navigator.push(context,
                                                //  MaterialPageRoute(builder: ((context) => 
                                                //  FareWidgets())));

                                              }, ),
                                             
                                              
                                          
                                        Container(
         
            width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.height * 0.08,
        decoration:
             BoxDecoration(color: Colors.teal, ),
          
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            ),
          ),
        ),
                                      ],
                                    ),
                                  ),
                                ))))
                  ]))),
    );
  
  
  }
}