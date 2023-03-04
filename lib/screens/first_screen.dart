import 'package:flutter/material.dart';
import 'package:ustad/widget/round_button.dart';
import 'package:ustad/screens/signup.dart';

import 'login.dart';

class FirstScreen extends StatefulWidget {
  static const routeName = '/first screen';
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage("image/download.jpg"),
                    fit: BoxFit.fill,
                  )
                ),
              ),
              SizedBox(height: 20,),
              RoundButton(title: "LogIn", onpress: (){
                Navigator.of(context).pushNamed(LogIn.routeName);
              } ),
              SizedBox(height: 10,),
              RoundButton(title: "SignUp", onpress: (){
                Navigator.of(context).pushNamed(SignUp.routeName);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
