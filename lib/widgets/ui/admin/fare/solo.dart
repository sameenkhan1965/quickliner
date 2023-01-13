import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:users_app/assistants/assistant_methods.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/models/direction_details_info.dart';

class FareWidgets extends StatefulWidget {
  const FareWidgets({super.key});

  @override
  State<FareWidgets> createState() => _FareWidgetsState();
}

class _FareWidgetsState extends State<FareWidgets> {
 bool isAdd=false;
  var totalPrice=0, money=0, petrol=0, distance=0;
  TextEditingController petrolPrice=TextEditingController();
  TextEditingController moneyPerKM=TextEditingController();
  TextEditingController distancePerkm=TextEditingController();

@override
  void initState() {
    // TODO: implement initState
   
    super.initState();
  }
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
                            SizedBox(width: getWidth(context)*0.25,),
                            
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
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                                                "Solo Fare",
                                                                style: TextStyle(
                                                                    color: Colors.black,
                                                                    fontWeight: FontWeight.normal,
                                                                    fontSize: 30),
                                                              ),
                                                              SizedBox(height: getHeight(context)*0.1,),
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
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .start,
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
                                               
                                               
                                              ],
                                            ),
                                          ),
                                        ),
                                         Center(
                                           child: ElevatedButton(
                                                  child: Text("Add"),
                                                  onPressed: (){
                                                  
                                                  if( petrolPrice.text.isEmpty&& moneyPerKM.text.isEmpty){
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
                                                    petrol= int.parse(petrolPrice.text);
                                                    money=int.parse(moneyPerKM.text);
                                                    totalPrice= money*petrol;
                                                    print("Total: $totalPrice");
                                    
                                                    Map fareMap =
                                        {
                                          "fare_type":"solo",
                                          "petrol_price": petrolPrice.text.trim(),
                                          "money_per_km": moneyPerKM.text.trim(),
                                          "total_price":totalPrice
                                        };
                                    
                                        DatabaseReference reference = FirebaseDatabase.instance.ref().
                                        child("Fare").ref.child('Solo');
                                        reference.set(fareMap).then((value){
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
                                    
  }),
                                         ),
                                             
                                              
                                        SizedBox(height: 20,),
                                        Container(
                                           
                                              width: MediaQuery.of(context).size.width * 0.95,
                                            height: MediaQuery.of(context).size.height * 0.08,
                                          decoration:
                                               BoxDecoration(color: Colors.teal,
                                                ),
                                            
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
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