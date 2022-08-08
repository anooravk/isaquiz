import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:isaquiz/rolesauth.dart';
import 'package:isaquiz/uploadquiz.dart';
import 'managingusers.dart';

Future main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: ManageUsers().handleAuth(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
class test extends StatelessWidget {
  const test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadQuiz()));
          }, child: Text('next')),
        ),
        Flexible(
          child: ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginEmail()));
          }, child: Text('auth')),
        ),
        Flexible(
          child: ElevatedButton(onPressed: (){
            ManageUsers().SignOut();
          }, child: Text('logout')),
        ),

      ],
    );
  }
}
