import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ustad/widget/round_button.dart';

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

void dialog(context,DataSnapshot id){
  showDialog(context: context, builder: (BuildContext){
    FirebaseAuth _auth = FirebaseAuth.instance;
    final dbRef = FirebaseDatabase.instance.ref('post');
    TextEditingController bidController = TextEditingController();
    String bid ='';
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              child: TextFormField(
                controller: bidController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Enter Bid price",
                  labelText: "Bid",
                  border: OutlineInputBorder(),
                ),
                onChanged: (String value){
                  bid = value;
                },
                validator: ((value) {
                  return value!.isEmpty?'Enter Bid':null;
                }),
              ),
            ),
            SizedBox(height: 5,),
            RoundButton(title: 'Bid Now', onpress: (){
              try{
                var r = DateTime.now().millisecondsSinceEpoch;
                User? user = _auth.currentUser;
                dbRef.child('Bider List').child('BID').child(id.value.toString()).child(r.toString()).set(
                    {
                      'pBid':bid,
                      'biderEmail': user!.email,
                      'bId': id.value.toString(),
                    }
                ).then((value) {
                  Navigator.pop(context);
                });
              }catch(e){
                print(e.toString());

              }
            })
          ],
        ),
      ),
    );
  });
}