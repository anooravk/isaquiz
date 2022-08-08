import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ViewResult extends StatefulWidget {
  @override
  _ViewResultState createState() => _ViewResultState();
}

final usersRef = FirebaseFirestore.instance.collection('user');
var emails;
var score;
var snap;
bool showSpinner=true;
List<DocumentSnapshot>? _myDocCount;
class _ViewResultState extends State<ViewResult> {
  @override
  void initState() {
    getUsers();
    super.initState();
  }

   getUsers()  {
    usersRef
        .where("role", isEqualTo: "user")
        .get()
        .then((QuerySnapshot snapshot) {
      {
        snapshot.docs.forEach((DocumentSnapshot doc) {
          emails = [doc['email']] as List?;
          score = [doc['score']] as List?;
          // print(emails.length);
          // print(score.length);
          snap=doc;
          // print(snap);
        });
      }
    });
    // return Text("${snap['email']} ${snap['score']}");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Center(
            child: Text(
              'Result',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25.0,
                fontFamily: 'Montserrat',
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: FutureBuilder(
              future:
              FirebaseFirestore.instance.collection('user').where("role", isEqualTo: "user").get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                showSpinner=true;
                if (snapshot.hasData) {
                showSpinner=false;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Users Email \t \t \t \t \t \t \t \t Users Score",style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                      ),),
                      SizedBox(height: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: snapshot.data?.docs.map((doc) {

                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 70.0, 0),
                            child: ListTile(
                             leading:Text( "${doc['email']} ",style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16.0,
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                            ),
                            ),
                              trailing:Text( "${doc['score']} ",style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16.0,
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                              ),
                              ),),
                          );
                        }).toList() ?? [],
                      ),
                    ],
                  );
                }else {
                  // or your loading widget here
                  return Container();
                }
                  },
                ),
        )
            ),
    );
  }
}
