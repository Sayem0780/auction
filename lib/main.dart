import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ustad/screens/add_post.dart';
import 'package:ustad/screens/first_screen.dart';
import 'package:ustad/screens/home_screen.dart';
import 'package:ustad/screens/login.dart';
import 'package:ustad/screens/signup.dart';
import 'package:ustad/screens/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auction App',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: SplashScreen(),
      routes: {
        SignUp.routeName:(context)=> SignUp(),
        LogIn.routeName:(context)=> LogIn(),
        HomeScreen.routeName:(context)=>HomeScreen(),
        AddPost.routeName:(context)=>AddPost(),
      },
    );
  }
}

