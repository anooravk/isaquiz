import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:isaquiz/dashboard.dart';
import 'package:isaquiz/reviewresul.dart';
import 'package:isaquiz/viewquiz.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'admindocsview.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'jsonmodel.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_auth/firebase_auth.dart';
import 'managingusers.dart';
import 'rolesauth.dart';
class UploadQuiz extends StatefulWidget {
  const UploadQuiz({Key? key}) : super(key: key);

  @override
  State<UploadQuiz> createState() => _UploadQuizState();
}

class _UploadQuizState extends State<UploadQuiz> {
  File? file;
  UploadTask? task;
  String? url;
  final databaseReference = FirebaseFirestore.instance;
  String user = FirebaseAuth.instance.currentUser!.uid;


  void getData() async {

    DocumentSnapshot documentSnapshot =
    await FirebaseFirestore.instance.collection('quiz').doc().get();
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() {
      file = File(path);
    });
  }

  Future uploadFile() async {

    if (file == null) return;
    final filePath = file!.path;
    var fileName = (filePath. split('/'). last);

    File jsonFile = await File("${filePath}");
    final destination = jsonFile.readAsStringSync();
    final welcome = welcomeFromJson(destination);
    await FirebaseFirestore.instance
        .collection("quiz")
        .doc(fileName)
        .set(welcome.toJson());
    getData();

  }



  @override
  Widget build(BuildContext context) {
    final fileName =
    file != null ? Path.basename(file!.path) : 'No file selected';

    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Center(
              child: Text('Admin area',style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25.0,
                fontFamily: 'Montserrat',
                color: Colors.white,
              ),),
            ),
          ),
          resizeToAvoidBottomInset: false,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildColumn(one: 'Create a Quiz', two: 'Enable Quiz',ione: Icons.note_add,itwo: Icons.upload_file,pressOne:(){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>dashBoard()));
              } ,pressTwo:(){
                // uploadFile();

                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>AdminDocsView()));

              } ),
              buildColumn(one: 'Review result', two: 'Logout',ione: Icons.remove_red_eye_sharp,itwo: Icons.logout,pressOne:(){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ViewResult()));
              } ,pressTwo:(){
                ManageUsers().SignOut();
                Navigator.pop(context);
              } ),
            ],
          ),
        ),
      ),
    );}

  Row buildColumn({required VoidCallback pressTwo,required VoidCallback pressOne,required String one, required String two, required IconData ione, required IconData itwo}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        SizedBox(height: 20,),
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
              Icon( ione,size: 35,color: Colors.white,),
              SizedBox(
                height: 10,
              ),
              Text(one,style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 15.0,
                fontFamily: 'Montserrat',
                color: Colors.white,
              ),)
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
              Icon(itwo,size: 35,color: Colors.white,),
              SizedBox(
                height: 10,
              ),
              Text(two,style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 15.0,
                fontFamily: 'Montserrat',
                color: Colors.white,
              ),)
            ],
          ),
        ),
      ),]
    );
  }

}


class Rounded_Button extends StatelessWidget {
  Rounded_Button({this.title, @required this.onPressed, this.colour,required this.icon});
  final Icon icon;
  final String? title;
  final Function()? onPressed;
  final Color? colour;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          // minWidth: 100.0,
          height: 42.0,
          child:
           Row(mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text(
                title!,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                ),),
               SizedBox(width: 10,),
               icon,
             ],
           ),
          ),
        ),
      );
  }

}
