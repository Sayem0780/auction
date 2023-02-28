import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ustad/screens/home_screen.dart';
import 'package:ustad/screens/login.dart';
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
    final user = _auth.currentUser;
    if(user !=null){
      Timer(Duration(seconds: 3), (){
        Navigator.of(context).pushNamed(HomeScreen.routeName);
      });
    }else{
      Timer(Duration(seconds: 3), (){
        Navigator.of(context).pushNamed(LogIn.routeName);
      });
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage("https://images.unsplash.com/photo-1579600161224-cac5a2971069?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHdlbGNvbWV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60"),
              fit: BoxFit.fill,
            ),

          ),
        ),
      ),
    );
  }
}
