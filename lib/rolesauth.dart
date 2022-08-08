import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:isaquiz/adminsignup.dart';
import 'package:isaquiz/listvewofmcqs.dart';
import 'package:isaquiz/managingusers.dart';
import 'package:isaquiz/signup.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'uploadquiz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginEmail extends StatefulWidget {
  @override
  State<LoginEmail> createState() => _LoginEmailState();
}

class _LoginEmailState extends State<LoginEmail> {
  String? email;
  String? password;
  final _auth = FirebaseAuth.instance;
bool showSpinner=false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                style: TextStyle(
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
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black,
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                    fontFamily: 'Montserrat',
                    color: Colors.grey,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                style: TextStyle(
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
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black,
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                    fontFamily: 'Montserrat',
                    color: Colors.grey,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Rounded_Button(
                icon: Icon(
                  Icons.login_rounded,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () async {
                  try {
                    setState(() {
                      showSpinner = true;
                    });
                    print(email);
                    final oldUser = await _auth.signInWithEmailAndPassword(
                        email: email!, password: password!);
                    final User? user = await _auth.currentUser;
                    final userUid = user!.uid;
                    var document = await FirebaseFirestore.instance
                        .collection('user')
                        .doc(userUid);
                    document.get().then((document) {
                      // print(document["role"]);
                      // ManageUsers().authorizeAccess(context);
                    });
                    if (oldUser != null) {
                      // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>UploadQuiz()));
                      ManageUsers().authorizeAccess(context);
                      setState(() {
                        showSpinner = false;
                      });
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                colour: Colors.black,
                title: 'Log In',
              ),
              SizedBox(
                height: 150,
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Center(
                      child: Text('Don\'t have an account? Create an account',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15.0,
                            fontFamily: 'Montserrat',
                            color: Colors.black,
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    RegisterAdminEmail()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Register as admin',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15.0,
                              fontFamily: 'Montserrat',
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    RegisterEmail()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Register as student',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15.0,
                              fontFamily: 'Montserrat',
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
