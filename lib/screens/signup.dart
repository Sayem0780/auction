import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:ustad/components/round_button.dart';

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
  String email="",password ="";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showsipnner,
      child: Scaffold(
        appBar: AppBar(title: Text("Create Account"),),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Confirm your password",
                        labelText: "Confirm Password",
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      onChanged: (String value){
                        password = value;
                      },
                      validator: ((value) {
                        return value!.isEmpty?'Confirm Your Password':null;
                      }),
                    ),
                    SizedBox(height: 15,),
                    RoundButton(title: "Sign Up", onpress: ()async{
                      if(_formKey.currentState!.validate()){
                        setState(() {
                          showsipnner = true;
                        });
                        try{
                          final user = _auth.createUserWithEmailAndPassword(email: email.toString().trim(), password: password.toString().trim());
                          if(user !=null){
                            print("Successfull");
                            toastMassage("Successfully Created");
                            setState(() {
                              showsipnner = false;
                            });
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
