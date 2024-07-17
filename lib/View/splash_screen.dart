import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'home_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState(){
    super.initState();
    Timer(Duration(seconds: 3),
        (){
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>HomeScreen()));});
  }
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.sizeOf(context).height*1;
    final width=MediaQuery.sizeOf(context).width*1;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
                fit: BoxFit.fill,
                height: height*.5,
                width: width*.9,
                image: AssetImage('images/splash_pic.jpg')),
SizedBox(height: height*.04,),

            Text('TOP HEADLINES',style: GoogleFonts.anton(letterSpacing: .6,color: Colors.grey.shade700),),
            SizedBox(height: height*.04,),
            SpinKitChasingDots(
              color:Colors.blue,
              size: 40,
            )
          ],
        ),
      ),
    );
  }
}
