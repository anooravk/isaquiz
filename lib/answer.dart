import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final  VoidCallback selectHandler;
  final String answerText;
  final Color colour;

  Answer(this.selectHandler, this.answerText,this.colour);

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: GestureDetector(
            onTap: selectHandler,
            child: Container(
              width: 390,
              height: 70,
              decoration: BoxDecoration(
                color: colour,
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
                  Text(answerText,style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.0,
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                  ),)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
