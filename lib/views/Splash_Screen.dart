import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Home_Screen.dart';

class Splesh_Screen extends StatefulWidget {
  const Splesh_Screen({Key? key}) : super(key: key);

  @override
  State<Splesh_Screen> createState() => _Splesh_ScreenState();
}

class _Splesh_ScreenState extends State<Splesh_Screen> {
  void initState() {
    Timer(
      Duration(seconds: 2),
      () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home_Screen(),
          )),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff8AD3FF),
      body: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(colors: [
          Color(0xff8AD3FF),
          Color(0xff86D0FC),
          Color(0xff2F8FC9),
          Color(0xff0C76B4)
        ], stops: [
          0.2,
          0.2,
          0.8,
          1.0
        ], radius: 1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Image.asset(
              'asserts/images/splesh_screenpng',
              width: 200,
              height: 200,
            )),
            Text(
              'HOW TO CREATE',
              style: GoogleFonts.acme(
                  color: Color(0xffFFFFFF),
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  wordSpacing: 5),
            ),
            Text(
              'ACCOUNT GUIDE',
              style: GoogleFonts.acme(
                  color: Color(0xffFFFFFF),
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  wordSpacing: 5),
            ),
          ],
        ),
      ),
    );
  }
}
