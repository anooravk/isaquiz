import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AdminDocsView extends StatefulWidget {
  @override
  State<AdminDocsView> createState() => _AdminDocsViewState();
}

bool one = false;
bool showSpinner = false;
IconData? icon = Icons.https;

class _AdminDocsViewState extends State<AdminDocsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Center(
            child: Text(
              'Enable/disable quizzes',
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
            future: FirebaseFirestore.instance.collection('quiz').get(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Availabe Quizzes",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: snapshot.data?.docs.map((doc) {
                            return Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 70.0, 0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showSpinner=true;
                                    });
                                    setState(() {
                                      one = !one;

                                      FirebaseFirestore.instance
                                          .collection('quiz')
                                          .doc(doc.id)
                                          .update({"enable": one});
                                      showDialog(
                                          context: context,
                                          builder: (_) => SimpleDialog(
                                            title: one?Text('Visible',style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15.0,
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                            ),):Text('Hidden',style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15.0,
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                            ),),
                                            children: [one?Text('${doc.id} has been made visisble.',style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15.0,
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                            ),):Text('${doc.id} has been locked.',style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15.0,
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                            ),)],
                                            contentPadding: EdgeInsets.all(25),
                                          ));


                                    });
                                    setState(() {
                                      showSpinner=false;
                                    });
                                  },
                                  child: ListTile(
                                    leading: Text(
                                      "${doc.id} ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16.0,
                                        fontFamily: 'Montserrat',
                                        color: Colors.black,
                                      ),
                                    ),
                                //    trailing:  Icon(icon),
                                  ),
                                ));
                          }).toList() ??
                          [],
                    ),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }
}
