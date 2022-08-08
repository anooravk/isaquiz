import 'package:flutter/material.dart';
class Nothing extends StatelessWidget {
  const Nothing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(
          'Quiz will begin shortly!',style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.normal,
          fontFamily: 'Montserrat',
          color: Colors.black,
          decoration: TextDecoration.none
        ),
        ),
      ),
    );
  }
}
