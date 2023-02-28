import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:ustad/screens/home_screen.dart';

import '../components/round_button.dart';
class LogIn extends StatefulWidget {
  static const routeName ="/log in";
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool showsipnner = false;
  final _formKey = GlobalKey<FormState>();
  String email="",password ="";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showsipnner,
      child: Scaffold(
        appBar: AppBar(title: Text("Log In"),),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Log In",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
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
                            return value!.isEmpty?'Enter Email':null;
                          }),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              hintText: "Enter your password",
                              labelText: "Password",
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                            onChanged: (String value){
                              password = value;
                            },
                            validator: ((value) {
                              return value!.isEmpty?'Enter Password':null;
                            }),
                          ),
                        ),
                        RoundButton(title: "Log In", onpress: ()async{
                          if(_formKey.currentState!.validate()){
                            setState(() {
                              showsipnner = true;
                            });
                            try{
                              final user = _auth.signInWithEmailAndPassword(email: email.toString().trim(), password: password.toString().trim());
                              if(user !=null){
                                print("Successfull");
                                toastMassage("Successfully Log In");
                                setState(() {
                                  showsipnner = false;
                                });
                                Navigator.of(context).pushNamed(HomeScreen.routeName);
                              }
                            }catch(e){
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
