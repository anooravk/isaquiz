import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:isaquiz/intermidiate.dart';
import 'package:isaquiz/managingusers.dart';
import 'package:isaquiz/nostartedyet.dart';
import 'package:isaquiz/rolesauth.dart';
import 'package:isaquiz/studentcore.dart';
import 'package:isaquiz/viewquiz.dart';
import 'uploadquiz.dart';
import 'uploadquiz.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class listViewOfMCQs extends StatefulWidget {
  listViewOfMCQs({this.id});
  String? id;

  @override
  _listViewOfMCQsState createState() => _listViewOfMCQsState();
}
int? quizid;
_showDialog(BuildContext context)  {
  Future.delayed(Duration(minutes: 10), ()async {
    String user = FirebaseAuth.instance.currentUser!.uid;
    String role = await FirebaseFirestore.instance
        .collection('user')
        .doc(user)
        .get()
        .then((value) {
      return value.data()!['role'];
    });
    print(role);
    if(role=="user")
    Navigator.pop(context);

    final snackBar = SnackBar(
      content: Text("Time's up :( Quiz has been disabled automatically."),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // buttonVisibilty = true;
  });

}

reshow() {
  Future.delayed(Duration(seconds: 20), () {
    buttonVisibilty = true;
  });
}


bool quizTakenOnce = false;
bool buttonVisibilty = true;
List docs=[];
class _listViewOfMCQsState extends State<listViewOfMCQs> {
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.black,
        title: Text(
          '       Student area',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 25.0,
            fontFamily: 'Montserrat',
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Flexible(
            child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("quiz").snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot)
                {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  for(int i=0;i<snapshot.data!.docs.length;i++) if(widget.id==snapshot.data!.docs[i].id) quizid=i;
                  var limit = snapshot.data?.docs[0];
                  Timestamp fail = Timestamp.fromDate(date);
                  Timestamp tempDaten =
                      limit?["revision"] ?? fail as Timestamp;
                  DateTime tempDate = tempDaten.toDate();
                  return SizedBox(
                    height: 300,
                    width: 350,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Visibility(
                              visible: true,
                              child: InkWell(
                                onTap: () {
                                  print('start: ${tempDate}');
                                  print('now: ${date}');
                                  print('pressed');
                                  setState(() {
                                    bool valDate = date.isAfter(tempDate);
                                    print(valDate);
                                    _showDialog(context);
                                    // reshow();
                                    if (valDate ==
                                        true) //&& quizTakenOnce==true)
                                    {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder:
                                                  (BuildContext context) =>
                                                      QFirebaseList(quizid!)));
                                    } else
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder:
                                                  (BuildContext context) =>
                                                      Nothing()));
                                  });
                                },
                                child: Container(
                                  height: 100.0,
                                  width: 150.0,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  padding: EdgeInsets.all(10.0),
                                  margin: EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.play_arrow,
                                        size: 35,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Start Quiz",
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0,
                                          fontFamily: 'Montserrat',
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            studResult()));

                              },
                              child: Container(
                                height: 100.0,
                                width: 150.0,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                padding: EdgeInsets.all(10.0),
                                margin: EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.remove_red_eye,
                                      size: 35,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "View Result",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15.0,
                                        fontFamily: 'Montserrat',
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        //                       buildColumn(
                        //                         itwo: Icons.remove_red_eye,
                        //                         pressTwo: (){
                        //                           Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>studResult()));
                        // },
                        //                         two: 'Check Result',
                        //                         ione: Icons.play_arrow,
                        //                         one: 'Start Quiz!',
                        //                         pressOne: () {
                        //                         print('start: ${tempDate}');print('now: ${date}');
                        //                           print('pressed');
                        //                           setState(() {
                        //                             bool valDate =
                        //                                 date.isAfter(tempDate) ;
                        //                             print(valDate);
                        //                             _showDialog(context);
                        //                             if(valDate==true )//&& quizTakenOnce==true)
                        //                             Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>FirebaseList()));
                        //                             else
                        //                             Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Nothing()));
                        //                           });
                        //                         },
                        //                       ),
                        Row(
                        children:[
                        InkWell(
                          onTap: () {

                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>DocsList()));

                          },
                          child: Container(
                            height: 100.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            padding: EdgeInsets.all(10.0),
                            margin: EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.list_alt_outlined,
                                  size: 35,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Select Quiz",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15.0,
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            ManageUsers().SignOut();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        LoginEmail()));
                          },
                          child: Container(
                            height: 100.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            padding: EdgeInsets.all(10.0),
                            margin: EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.logout,
                                  size: 35,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Logout",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15.0,
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),],),
                      ],
                    ),
                  );
                }),
          ),
        ]),
      ),
    );
  }

  Row buildColumn(
      {required VoidCallback pressTwo,
      required VoidCallback pressOne,
      required String one,
      required String two,
      required IconData ione,
      required IconData itwo}) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
        height: 20,
      ),
      InkWell(
        onTap: pressOne,
        child: Container(
          height: 100.0,
          width: 150.0,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Icon(
                ione,
                size: 35,
                color: Colors.white,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                one,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15.0,
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
      InkWell(
        onTap: pressTwo,
        child: Container(
          height: 100.0,
          width: 150.0,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Icon(
                itwo,
                size: 35,
                color: Colors.white,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                two,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15.0,
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    ]);
  }
}
