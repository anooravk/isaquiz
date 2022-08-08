import 'package:firebase_database/firebase_database.dart';
import 'package:isaquiz/viewquiz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'uploadquiz.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:isaquiz/rolesauth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'managingusers.dart';
class RegisterAdminEmail extends StatefulWidget {

  @override
  State<RegisterAdminEmail> createState() => _RegisterAdminEmailState();
}

class _RegisterAdminEmailState extends State<RegisterAdminEmail> {
  String? email;
  String? password;
  String? name;
  String? subject;
   User? user;
  String? userUid;
  String? code;
  String hardcode="sfml123";
  final _auth = FirebaseAuth.instance;
bool showSpinner=false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset:false,
        backgroundColor: Colors.white,
        body:  ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(  style:  TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18.0,
                fontFamily: 'Montserrat',
                color: Colors.white,
              ),
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  subject = value;
                },
                decoration:InputDecoration(
                  filled: true,
                  fillColor: Colors.black,
                  hintText: 'Enter your subject',hintStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.0,
                  fontFamily: 'Montserrat',
                  color: Colors.grey,
                ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),),
              SizedBox(
                height: 8.0,
              ),
              TextField(  style:  TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18.0,
                fontFamily: 'Montserrat',
                color: Colors.white,
              ),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  name = value;
                },
                decoration:InputDecoration(
                  filled: true,
                  fillColor: Colors.black,
                  hintText: 'Enter your name',hintStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.0,
                  fontFamily: 'Montserrat',
                  color: Colors.grey,
                ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),),
              SizedBox(height: 8,),
              TextField(  style:  TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18.0,
                fontFamily: 'Montserrat',
                color: Colors.white,
              ),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  code = value;
                },
                decoration:InputDecoration(
                  filled: true,
                  fillColor: Colors.black,
                  hintText: 'Enter admin code',hintStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.0,
                  fontFamily: 'Montserrat',
                  color: Colors.grey,
                ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),),
              SizedBox(
                height: 8.0,
              ),
              TextField(  style:  TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18.0,
                fontFamily: 'Montserrat',
                color: Colors.white,
              ),
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration:InputDecoration(
                  filled: true,
                  fillColor: Colors.black,
                  hintText: 'Enter your email',hintStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.0,
                  fontFamily: 'Montserrat',
                  color: Colors.grey,
                ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                style:  TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.0,
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration:InputDecoration(
                  filled: true,
                  fillColor: Colors.black,
                  hintText: 'Enter your password',hintStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.0,
                  fontFamily: 'Montserrat',
                  color: Colors.grey,
                ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),),),
              SizedBox(
                height: 24.0,
              ),
              Rounded_Button(
                icon: Icon(Icons.person_add,size: 30,color: Colors.white,),
                onPressed: () async {
                  if(code==hardcode){
                  try {
                    setState(() {
                      showSpinner=true;
                    });
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email!, password: password!);
                    user=await _auth.currentUser;
                    userUid=user!.uid;
                    print(userUid);
                    FirebaseFirestore.instance.collection('user').doc(userUid).set({"email":email,"name":name,"subject":subject,"role":"admin","uid":userUid,"created on":FieldValue.serverTimestamp()});

                    if (newUser != null) {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginEmail()) );
                      setState(() {
                        showSpinner=false;
                      });
                    }
                  } catch (e) {
                    print(e);
                  }
                }else{
                    showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return AlertDialog(
                            title: Text("Invalid"),
                            content: Text("You cant be an admin since the admin code is incorrect"),
                          );
                        }
                    );
              }},
                title: 'Register',
                colour: Colors.black,
              )

            ],
          ),
        ),
      ),
    );
  }
}
