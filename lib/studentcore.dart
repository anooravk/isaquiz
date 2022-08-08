import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class studResult extends StatefulWidget {
  const studResult({Key? key}) : super(key: key);

  @override
  _studResultState createState() => _studResultState();

}


String? scoreTotal;
String user = FirebaseAuth.instance.currentUser!.uid;
authorizeAccess() async {
  String user = FirebaseAuth.instance.currentUser!.uid;
  String role = await FirebaseFirestore.instance
      .collection('user')
      .doc(user)
      .get()
      .then((value) {
    return value.data()!['role'];
  });
   if (role == "user") {
    scoreTotal=await FirebaseFirestore.instance
        .collection('user')
        .doc(user)
        .get()
        .then((value) {
      return value.data()!['score'].toString();
    });
  }
  print(scoreTotal);

}

class _studResultState extends State<studResult> {

  @override
  Widget build(BuildContext context) {
    authorizeAccess();
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              'Result',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Montserrat',
                  color: Colors.white),
            ),
          ),
          body:
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  height: 100.0,
                  width: 255.0,
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
                      Icon(Icons.score,size: 35,color: Colors.white,),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Your total score is : ${scoreTotal}'
                        ,style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15.0,
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                      ),)
                    ],
                  ),
                ),
              ],
            ),
          ),

      ),
    );
  }}
