import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ustad/screens/first_screen.dart';
import 'package:ustad/screens/home_screen.dart';
import 'package:ustad/screens/login.dart';
import 'package:ustad/screens/signup.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    // final user=_auth.currentUser;
    Timer(Duration(seconds: 3), (){
      Navigator.of(context).pushNamed(FirstScreen.routeName);
    });
    // if(user !=null){
    //   Timer(Duration(seconds: 3), (){
    //     Navigator.of(context).pushNamed(HomeScreen.routeName);
    //   });
    // }else{
    //   Timer(Duration(seconds: 3), (){
    //     Navigator.of(context).pushNamed(LogIn.routeName);
    //   });
    // }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height*.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage("image/game.jpg"),
                  fit: BoxFit.cover,
                ),

              ),
            ),
            SizedBox(height: 50,),
            Text("Wellcome",style: TextStyle(fontSize: 35,fontWeight: FontWeight.w900),),
          ],
        ),
      ),
    );
  }
}
