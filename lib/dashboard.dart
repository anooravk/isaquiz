import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:isaquiz/jsonmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class dashBoard extends StatefulWidget {
  const dashBoard({Key? key}) : super(key: key);

  @override
  State<dashBoard> createState() => _dashBoardState();
}

List<Question>? tst = [];

var contollerQuestion = TextEditingController();
var contollerchoice1 = TextEditingController();
var contollerchoice2 = TextEditingController();
var contollerchoice3 = TextEditingController();
var contollerAnswer = TextEditingController();
var contollerstatic = TextEditingController();
var contollerdate = TextEditingController();
bool showSpinner=false;
List<String> correctAnswers = [];
List<Widget> bodyElements = [];
int num = 0;
final dbref = FirebaseFirestore.instance.collection("quiz");
final quizUploader = FirebaseAuth.instance.currentUser!.email;
String? subject;

class _dashBoardState extends State<dashBoard> {

  @override
  void updateindb() async {
    // String dt=contollerdate.text+contollertime.text;
    DateTime td=DateTime.parse(contollerdate.text);
    Welcome welcome = await Welcome(
        enable: false,
        revision: td,
        quiztitle: contollerstatic.text,
        questions: tst);

    setState(() {
      dbref.doc(contollerstatic.text).set(welcome.toJson());
      // answers!.clear();
    });
  }
@override
  void dispose() {
    // contollerdate.dispose();
    // contollerstatic.dispose();
    // contollerAnswer.dispose();
    // contollerQuestion.dispose();
    // contollerchoice1.dispose();
    // contollerchoice2.dispose();
    // contollerchoice3.dispose();
    super.dispose();
  }
  @override
  void updateinlist() async {
    setState(() {
      List<String>? answers = [];
      answers.add(contollerchoice1.text);
      answers.add(contollerchoice2.text);
      answers.add(contollerchoice3.text);
      Question w = new Question(
          question: contollerQuestion.text,
          answers: answers,
          correctAnswer: contollerAnswer.text);
      tst!.add(w);
      // bodyElements.add(addBodyElement( contollerQuestion.text, contollerchoice1.text, contollerchoice2.text, contollerchoice3.text, contollerAnswer.text));
      contollerchoice1.clear();
      contollerchoice2.clear();
      contollerchoice3.clear();
      contollerQuestion.clear();
      contollerAnswer.clear();
    });
  }

  Widget build(BuildContext context) {

    AlertDialog alert = AlertDialog(
      title: Text(
        'Save',
        style: TextStyle(
          fontFamily: 'Montserrat',
          color: Colors.black,
          fontSize: 23.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Text(
        'Do you want to save your quiz?',
        style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.normal),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () async {
            setState(() {
              showSpinner=true;
            });
            updateindb();
            Navigator.pop(context, 'yes');
            setState(() {
              showSpinner=false;
            });
          },
          child: Text(
            'yes',
            style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.normal),
          ),
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context, 'no'),
          child: Text(
            'no',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Montserrat',
                fontSize: 20.0,
                fontWeight: FontWeight.normal),
          ),
        ),
      ],
      backgroundColor: Colors.white,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                      barrierDismissible: false);
                },
                icon: Icon(Icons.save))
          ],
          backgroundColor: Colors.black,
          title: Center(
            child: Text(
              'Add Questions',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25.0,
                fontFamily: 'Montserrat',
                color: Colors.white,
              ),
            ),
          ),
          leading: IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  bodyElements.clear();
                  contollerchoice1.clear();
                  contollerchoice2.clear();
                  contollerchoice3.clear();
                  contollerQuestion.clear();
                  contollerAnswer.clear();
                  contollerstatic.clear();
                  contollerdate.clear();
                  num = 0;
                  tst!.clear();
                });
              })),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {

           num++;
           print(num);
          setState(() {
            updateinlist();
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      body:      ListView(
       children: [
          Container(

            child: Wrap(
              children: [
                buildStatic(),
                builddate(),
                buildPadding(),
                buildChoice1(),
                buildChoice2(),
                buildChoice3(),
                buildAnswer()],
            ),
          ),
          Column(
            children: bodyElements,
          )
        ],),


    );
  }

  Widget buildPadding() {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: contollerQuestion,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
              fontFamily: 'Montserrat',
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
            obscureText: false,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black,
              hintText: "Enter question",
              hintStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18.0,
                fontFamily: 'Montserrat',
                color: Colors.grey,
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildChoice3() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: contollerchoice3,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18.0,
          fontFamily: 'Montserrat',
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
        obscureText: false,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black,
          hintText: "enter choice 3",
          hintStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
            fontFamily: 'Montserrat',
            color: Colors.grey,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
        ),
      ),
    );
  }

  Widget buildChoice2() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: contollerchoice2,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18.0,
          fontFamily: 'Montserrat',
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
        obscureText: false,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black,
          hintText: "enter choice 2"
              "",
          hintStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
            fontFamily: 'Montserrat',
            color: Colors.grey,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
        ),
      ),
    );
  }

  Widget buildChoice1() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: contollerchoice1,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18.0,
          fontFamily: 'Montserrat',
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
        obscureText: false,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black,
          hintText: "enter choice 1",
          hintStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
            fontFamily: 'Montserrat',
            color: Colors.grey,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
        ),
      ),
    );
  }

  Widget buildAnswer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: contollerAnswer,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18.0,
          fontFamily: 'Montserrat',
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
        obscureText: false,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black,
          hintText: "enter correct answer",
          hintStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
            fontFamily: 'Montserrat',
            color: Colors.grey,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
        ),
      ),
    );
  }
  Widget buildStatic() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: contollerstatic,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18.0,
          fontFamily: 'Montserrat',
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
        obscureText: false,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black,
          hintText: "quiz title",
          hintStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
            fontFamily: 'Montserrat',
            color: Colors.grey,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
        ),
      ),
    );
  }

  Widget builddate() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: contollerdate,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18.0,
          fontFamily: 'Montserrat',
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
        obscureText: false,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black,
          hintText: "yy/mm/dd hh/mm",
          hintStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
            fontFamily: 'Montserrat',
            color: Colors.grey,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
        ),
      ),
    );
  }
  Widget addBodyElement(String question, String choice1, String choice2,
      String choice3, String correctanswer) {

      return Row(
        children: [
          Column(children: [
            SizedBox(
              height: 20,
            ),
            Text("question: $question",overflow: TextOverflow.ellipsis,maxLines: 2,),
            Text("choice1: $choice1",overflow: TextOverflow.ellipsis,maxLines: 2,),
            Text("choice2: $choice2",overflow: TextOverflow.ellipsis,maxLines: 2,),
            Text("choice3: $choice3",overflow: TextOverflow.ellipsis,maxLines: 2,),
            Text("answer: $correctanswer",overflow: TextOverflow.ellipsis,maxLines: 2,),
          ]),
        ],
      );

  }
}
