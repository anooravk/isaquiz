import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:isaquiz/answer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:isaquiz/studentcore.dart';
import 'package:isaquiz/uploadquiz.dart';


class QFirebaseList extends StatefulWidget {
QFirebaseList(this.id);
int id;
  @override
  _QFirebaseListState createState() => _QFirebaseListState();
}

class _QFirebaseListState extends State<QFirebaseList> with TickerProviderStateMixin {

  late AnimationController controller;

  bool isPlaying = false;


  String get countText {
  Duration count = controller.duration! * controller.value;
  return controller.isDismissed
  ? '${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
      : '${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }
  Color colors=Colors.black54;
  int questionIndex = 0;
  bool answerSelected = false;
  bool answerWasSelected = false;
  int totalScore = 0;
  bool endOfQuiz = false;
  bool callsettste = true;
  String? chosenAnswer;
  DateTime? day = DateTime.now();
  User? user;
  String? userUid;
  bool tapped=false;
  final _auth = FirebaseAuth.instance;
  String next="Next";
void checkValdity(){
  endOfQuiz = true;

}
void getUser()async{
  user=await _auth.currentUser;
  userUid=user!.uid;
}
  @override
  void initState() {
    // _questionAnswered();

    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds:600),
    );
    controller.reverse(
        from: controller.value == 0 ? 1.0 : controller.value);
    getUser();


  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  void _questionAnswered()  {
    setState(() {
      answerSelected = true;
    });
  }
  void notify() {
  setState(() {
    if (countText == '00:00') {
      Navigator.pop(context);
      final snackBar = SnackBar(
        content: Text("Time's up :( Quiz has been disabled automatically."),
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar);
    }
  });
  }

  void _nextQuestion(limit) {
    setState(() {
      answerSelected = false;
      questionIndex++;
      if (questionIndex+1==
          limit['questions'].length )
        checkValdity();
      if(limit['questions'].length-1==questionIndex+1)
        next="submit";

    });
  }

  @override
  Widget build(BuildContext context) {
    notify();
    return Scaffold(

        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              StreamBuilder(
                  stream:
                      FirebaseFirestore.instance.collection("quiz").snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return CircularProgressIndicator();
                    var limit = snapshot.data!.docs[widget.id];
                    var check =
                        limit['questions'][questionIndex]['correct_answer'].toString();

                    return  ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: [

                      Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: AnimatedBuilder(
                          animation: controller,
                          builder: (context, child) => Text(
                            countText,
                    style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 50.0,
                    fontFamily: 'Montserrat',
                    color: Colors.black,),
                          ),),
                        ),
                      ),
                              SizedBox(
                                height: 20,
                              ),
                              buildContainer(limit),
                              SizedBox(
                                height: 20,
                              ),
                              Answer(() {
if(answerSelected)return;
                                _questionAnswered();
                                chosenAnswer = limit['questions'][questionIndex]['answers'][0].toString();
                                if (check == chosenAnswer)
                                  ++totalScore;
                                  FirebaseFirestore.instance.collection('user').doc(userUid).update({"score":totalScore});

                              },
                                  limit['questions'][questionIndex]['answers']
                                          [0]
                                      .toString(), answerSelected?Colors.black:Colors.black54
                                  ),
                              SizedBox(
                                height: 20,
                              ),
                              Answer(() {

                                if(answerSelected)return;
                    _questionAnswered();
                    chosenAnswer = limit['questions'][questionIndex]['answers'][1].toString();
                    if (check == chosenAnswer)
                    ++totalScore;
                    FirebaseFirestore.instance.collection('user').doc(userUid).update({"score":totalScore});

                    },
                    limit['questions'][questionIndex]['answers']
                    [1]
                        .toString(), answerSelected?Colors.black:Colors.black54


                              //   if (questionIndex + 1 ==
                              //       limit['questions'].length) {
                              //     endOfQuiz = true;
                              //     Navigator.pop(context);
                              //     final snackBar = SnackBar(
                              //       content: Text('Sucessfully Submitted!'),
                              //     );
                              //     ScaffoldMessenger.of(context)
                              //         .showSnackBar(snackBar);
                              //   }
                              //
                              //   if (answerSelected) return;
                              //   _questionAnswered();
                              //   chosenAnswer = 1;
                              //   if (check == chosenAnswer) {
                              //     totalScore++;
                              //     FirebaseFirestore.instance.collection('user').doc(userUid).update({"score":totalScore});
                              //   }
                              //
                              //
                              // },
                              //     limit['questions'][questionIndex]['answers']
                              //             [1]
                              //         .toString(),
                              //     Colors.black54
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Answer(() {

                                if(answerSelected)return;
                                _questionAnswered();
                                chosenAnswer = limit['questions'][questionIndex]['answers'][2].toString();
                                if (check == chosenAnswer)
                                  ++totalScore;
                                FirebaseFirestore.instance.collection('user').doc(userUid).update({"score":totalScore});
                              },
                                  limit['questions'][questionIndex]['answers']
                                  [2]
                                      .toString(),
                                  answerSelected?Colors.black:Colors.black54

                              //   if (questionIndex + 1 ==
                              //       limit['questions'].length) {
                              //     endOfQuiz = true;
                              //     print('end of quiz $endOfQuiz');
                              //     Navigator.pop(context);
                              //     final snackBar = SnackBar(
                              //       content: Text('Sucessfully Submitted!'),
                              //     );
                              //     ScaffoldMessenger.of(context)
                              //         .showSnackBar(snackBar);
                              //   }
                              //   if (answerSelected) return;
                              //   _questionAnswered();
                              //   chosenAnswer = 2;
                              //   if (check == chosenAnswer) {
                              //     FirebaseFirestore.instance.collection('user').doc(userUid).update({"score":totalScore});
                              //     totalScore++;
                              //   }
                              //
                              //   print('score $totalScore');
                              // },
                              //     limit['questions'][questionIndex]['answers']
                              //             [2]
                              //         .toString(),
                              //     Colors.black54
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              GestureDetector(
                                onTap:(){_nextQuestion(limit);
                                  if(endOfQuiz==true)
                                  {
                                    final snackBar = SnackBar(
                                      content: Text('Sucessfully Submitted!'),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  Navigator.pop(context);
                                  }},
                                child: Container(
                                      height: 60.0,
                                      width: 250.0,
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
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(next,style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15.0,
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                          ),)
                                        ],
                                      ),
                                    ),
                              ),

                            ],
                          );
                  })
            ],
          ),
        ));
  }

  Widget buildContainer(QueryDocumentSnapshot<Object?> document) {
    return Container(

      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(document['questions'][questionIndex]['question'].toString(),style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20.0,
            fontFamily: 'Montserrat',
            color: Colors.white,
          ),)
        ],
      ),
    );
  }
}
