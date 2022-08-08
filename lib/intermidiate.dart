import 'package:firebase_database/ui/firebase_list.dart';
import 'package:flutter/material.dart';
import 'package:isaquiz/listvewofmcqs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'viewquiz.dart';
class DocsList extends StatefulWidget {

  @override
  State<DocsList> createState() => _DocsListState();
}

bool one=true;
class _DocsListState extends State<DocsList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text('Choose a quiz',style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 25.0,
            fontFamily: 'Montserrat',
            color: Colors.white,
          ),),
        ),
      ),
      body: FutureBuilder(
        future:
        FirebaseFirestore.instance.collection('quiz').where("enable",isEqualTo: true).get(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
          // print(snapshot.data!.docs[0].id);
          if (snapshot.hasData) {
            return Column(

              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Availabe Quizzes",style: TextStyle(
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
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder:
                                      (BuildContext context) =>
                                          listViewOfMCQs(id:doc.id)));
                        },
                        child: ListTile(
                          leading:Text( "${doc.id} ",style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16.0,
                            fontFamily: 'Montserrat',
                            color: Colors.black,
                          ),
                          ),),
                      ),
                    );
                  }).toList() ?? [],
                ),
              ],
            );
          }else {
            return Center(child: CircularProgressIndicator());
          }
        },
      )
    );
  }
}
