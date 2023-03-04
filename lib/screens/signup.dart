import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:ustad/screens/first_screen.dart';
import 'package:ustad/widget/round_button.dart';
import 'package:ustad/screens/login.dart';

class SignUp extends StatefulWidget {
  static const routeName ='/sign up';
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool showsipnner = false;
  final _formKey = GlobalKey<FormState>();
  String email="",password ="",confirmpassword="";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showsipnner,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Create Account",style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sign Up",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Form(
                    key: _formKey,
                      child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Enter your Email",
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String value){
                          email = value;
                        },
                        validator: ((value) {
                          return value!.contains('@')?null:'Pls Enter Valid Email';
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.numberWithOptions(),
                          decoration: InputDecoration(
                            hintText: "Passowrd should contain 8 charecter",
                            labelText: "Password",
                            prefixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String value){
                            password = value;
                          },
                          validator: ((value) {
                            if(value!.isEmpty)
                            {return 'Enter Password';} else if(value!.length<8){
                              return 'Password should contain at least 8 character';
                            }else if(value!.characters == null){
                              return 'Password should contain at least one character';
                            }else{
                              return null;
                            }
                          }),
                        ),
                      ),
                      TextFormField(
                        controller: confirmpasswordController,
                        keyboardType: TextInputType.numberWithOptions(),
                        decoration: InputDecoration(
                          hintText: "Confirm your password",
                          labelText: "Confirm Password",
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(),
                        ),

                        onChanged: (String value){
                          confirmpassword = value;
                        },
                        validator: ((value) {
                          return value.toString()==password?null:'Pls Confirm Your Password';
                        }),
                      ),
                      SizedBox(height: 15,),
                      RoundButton(title: "Sign Up", onpress: ()async{
                        if(_formKey.currentState!.validate()){
                          setState(() {
                            showsipnner = true;
                          });
                          final user = _auth.createUserWithEmailAndPassword(email: email.toString().trim(), password: password.toString().trim());
                          try{
                              user.then((value) => {
                              setState(() {
                              showsipnner = false;
                              Navigator.of(context).pushNamed(LogIn.routeName);
                              })
                              }).onError((error, stackTrace) => {
                                  toastMassage(error.toString()),
                                setState(() {
                                  showsipnner = false;
                                  Timer(Duration(seconds: 2), (){
                                    Navigator.of(context).pushNamed(FirstScreen.routeName);
                                  });
                                }),

                              });

                          }on FirebaseAuthException catch(e){
                            print(e.toString());
                            toastMassage(e.toString());
                            setState(() {
                              showsipnner = false;
                            });
                          }
                        }
                      })
                    ],
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  void toastMassage(String massage){
  Fluttertoast.showToast(
  msg: massage,
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.SNACKBAR,
  timeInSecForIosWeb: 1,
  backgroundColor: Colors.red,
  textColor: Colors.white,
  fontSize: 16.0
  );
  }
}
