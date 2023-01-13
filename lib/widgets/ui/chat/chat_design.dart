
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:users_app/global/colors.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/models/trips_history_model.dart';

class ChatDesign extends StatefulWidget {
  TripsHistoryModel tripsHistoryModel;
  ChatDesign({Key? key,required this.tripsHistoryModel}) : super(key: key);

  @override
  State<ChatDesign> createState() => _ChatDesignState();
}

class _ChatDesignState extends State<ChatDesign> {

  DatabaseReference? _reference;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver"),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseDatabase.instance.ref().child("chat").child('${widget.tripsHistoryModel.driverId}${currentFirebaseUser!.uid}').onValue,
          builder: (context, AsyncSnapshot snapShot){
            // Map<dynamic,dynamic>? data=snapShot.data;
            // Map<String, dynamic> map=snapShot.data!.snapshot.value;
            // print((map["sender"].value));
            // print(snapShot.data!.snapshot.value[0]["sender"]);
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: Text(""),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration:InputDecoration(
                        filled: true,
                        fillColor: AppColors.blackColor.withOpacity(0.2),
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: (){
                            sendMessage("HI");
                          },
                        )
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  sendMessage(String message) {
    //1. save the RideRequest Information
    _reference= FirebaseDatabase.instance
        .ref()
      .child("chat").child('${widget.tripsHistoryModel.driverId}${currentFirebaseUser!.uid}')
        .push(); //push is for generating a random unique id



    _reference!.set({
      "sender":message??"",
    });
  }
}
