import 'package:flutter/material.dart';
import 'package:ustad/components/round_button.dart';
import 'package:ustad/screens/signup.dart';

import 'login.dart';

class FirstScreen extends StatefulWidget {
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
                    image: NetworkImage("https://media.istockphoto.com/id/1399348612/photo/hello-written-rectangular-shaped-yellow-chat-bubble-on-turquoise-background.jpg?b=1&s=170667a&w=0&k=20&c=fFfp1GiZhtmyHfcOI3VkdhV8nt9upRhd4x6x947Zs_E="),
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
