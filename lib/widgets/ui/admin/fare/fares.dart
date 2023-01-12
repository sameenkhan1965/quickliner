import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/widgets/ui/admin/fare/broadcast.dart';
import 'package:users_app/widgets/ui/admin/fare/carpool.dart';
import 'package:users_app/widgets/ui/admin/fare/permanent.dart';
import 'package:users_app/widgets/ui/admin/fare/schedule.dart';
import 'package:users_app/widgets/ui/admin/fare/solo.dart';

class Fare extends StatefulWidget {
  const Fare({super.key});

  @override
  State<Fare> createState() => _FareState();
}

class _FareState extends State<Fare> {
  var salary = 5000;
  var months = 5;
  // var months = 5;

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
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(onPressed: (){
                              Navigator.pop(context);
                            }, icon: Icon(Icons.arrow_back)),
                            SizedBox(width: getWidth(context)*0.3,),
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
                            child: Column(
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        reusableFareWidget(
                                          onTap:()=> Navigator.push(
                                context,
                                MaterialPageRoute(
                       builder: (context) => FareWidgets()),
                        ),
                        fareType: "Solo",
                        clr: Colors.teal,
                                        ),
                                        reusableFareWidget(
                                          onTap:()=> Navigator.push(
                                context,
                                MaterialPageRoute(
                       builder: (context) => Schedule()),
                        ),
                        fareType: "Schedule",
                        clr: Colors.yellow,
                                        ),
                                        
                                      ],
                                    )
                                    
                                    ),
                              
                               Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        reusableFareWidget(
                                          onTap:()=> Navigator.push(
                                context,
                                MaterialPageRoute(
                       builder: (context) => Permanent()),
                        ),
                        fareType: "Permanent",
                        clr: Colors.grey,
                                        ),
                                        reusableFareWidget(
                                          onTap:()=> Navigator.push(
                                context,
                                MaterialPageRoute(
                       builder: (context) => CarPOOLFare()),
                        ),
                        fareType: "CarPool",
                        clr: Colors.teal,
                                        ),
                                        
                                      ],
                                    ),
                                    
                                    
                                    
                                    
                                    
                                    ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: reusableFareWidget(
                                            onTap:()=> Navigator.push(
                                  context,
                                  MaterialPageRoute(
                       builder: (context) => BroadcastFare()),
                        ),
                        fareType: "Broad Cast",
                        clr: Colors.amberAccent,
                                          ),
                              ),
                              
                              ],
                            )
                                
                                
                                )
                                )
                 
                 
                  ]))),
    );
  
  
  }
}

class reusableFareWidget extends StatelessWidget {
   reusableFareWidget({
    Key? key,
   required this.onTap, this.fareType,
   this.clr
  }) : super(key: key);

VoidCallback onTap;
String? fareType;
Color? clr;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: onTap,
        child: Container(
         
            width: MediaQuery.of(context).size.width * 0.35,
          height: MediaQuery.of(context).size.height * 0.18,
        decoration:
             BoxDecoration(color: clr, borderRadius: BorderRadius.circular(35)),
          
          child: Center(
            
            child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(fareType!,
                style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700
              )
              ),
             
            ],
          )),
        ),
      
      
      );
  }
}
