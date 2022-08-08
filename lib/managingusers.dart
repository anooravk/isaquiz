import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:isaquiz/listvewofmcqs.dart';
import 'package:isaquiz/rolesauth.dart';
import 'package:isaquiz/uploadquiz.dart';
import 'main.dart';
import 'viewquiz.dart';

class ManageUsers {

  Widget handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return LoginEmail();
        }
        return LoginEmail();
      },
    );
  }

  SignOut() {
    FirebaseAuth.instance.signOut();
  }

  Stream<DocumentSnapshot> provideDocumentFieldStream() {
    return FirebaseFirestore.instance.collection('user').doc().snapshots();
  }

  handleLogin() {
    StreamBuilder<DocumentSnapshot>(
        stream: provideDocumentFieldStream(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> documentFields =
                snapshot.data!.data() as Map<String, dynamic>;
            print(documentFields['role']);
            return Text(documentFields['role']);
          }
          return test();
        });
  }

  authorizeAccess(BuildContext context) async {
    String user = FirebaseAuth.instance.currentUser!.uid;
    String role = await FirebaseFirestore.instance
        .collection('user')
        .doc(user)
        .get()
        .then((value) {
      return value.data()!['role'];
    });
    if (role == "admin") {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => UploadQuiz()));
    } else if (role == "user") {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => listViewOfMCQs(id: "oop",)));
    }
  }
}
