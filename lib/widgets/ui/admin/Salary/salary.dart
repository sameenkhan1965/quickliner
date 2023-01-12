import 'package:flutter/material.dart';

class Salary extends StatefulWidget {
  const Salary({super.key});

  @override
  State<Salary> createState() => _SalaryState();
}

class _SalaryState extends State<Salary> {
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Driver's Salary",
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
                                padding: EdgeInsets.all(20),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height *
                                      0.65,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                          Column(
                                              children: [
                                                reusablecontainer(
                                                    context,
                                                    Colors.teal,
                                                    "Drivers's Name",
                                                    "Number",
                                                    salary,
                                                    months),
                                              
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.30,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Icon(Icons.edit),
                                                      Icon(Icons.delete),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                            ],
                                            ),
                                            SizedBox(height: MediaQuery.of(context).size.height*0.015,),
                                            Column(
                                              children: [
                                                reusablecontainer(
                                                    context,
                                                    Colors.amberAccent,
                                                    "Drivers's Name",
                                                    "Number",
                                                    salary,
                                                    months),
                                              
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.30,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Icon(Icons.edit),
                                                      Icon(Icons.delete),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                            ],
                                            ),
                                            SizedBox(height: MediaQuery.of(context).size.height*0.015,),
                                            Column(
                                              children: [
                                                reusablecontainer(
                                                    context,
                                                    Colors.grey,
                                                    "Drivers's Name",
                                                    "Number",
                                                    salary,
                                                    months),
                                              
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.30,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Icon(Icons.edit),
                                                      Icon(Icons.delete),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                            ],
                                            ), 
                                            SizedBox(height: MediaQuery.of(context).size.height*0.015,),
                                            Column(
                                              children: [
                                                reusablecontainer(
                                                    context,
                                                    Colors.teal,
                                                    "Drivers's Name",
                                                    "Number",
                                                    salary,
                                                    months),
                                              
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.30,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Icon(Icons.edit),
                                                      Icon(Icons.delete),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                            ],
                                            ),
                                            SizedBox(height: MediaQuery.of(context).size.height*0.015,),
                                            Column(
                                              children: [
                                                reusablecontainer(
                                                    context,
                                                    Colors.amberAccent,
                                                    "Drivers's Name",
                                                    "Number",
                                                    salary,
                                                    months),
                                              
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.30,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Icon(Icons.edit),
                                                      Icon(Icons.delete),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                            ],
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

Container reusablecontainer(BuildContext context, Color clr, String title,
    String sbtitle, int salary, int months) {
  return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.11,
      decoration:
          BoxDecoration(color: clr, borderRadius: BorderRadius.circular(35)),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: ListTile(
          title: Text("$title"),
          subtitle: Text("$sbtitle"),
          trailing: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Earning",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("$salary"),
                    ],
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Persentage",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("$months"),
                    ],
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Salary",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("${salary * months}"),
                    ],
                  ),
                ],
              )),
        ),
      ));
}
