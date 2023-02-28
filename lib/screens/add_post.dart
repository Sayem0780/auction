import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/round_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class AddPost extends StatefulWidget {
  static const routeName ='/add post';
  const AddPost({Key? key}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  File? _image;
  final picker = ImagePicker();
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _postref = FirebaseDatabase.instance.ref.call("post");
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  bool showsipnner = false;
  final _formKey = GlobalKey<FormState>();
  String title="",description ="";
  late double price ;
  late DateTime timeline ;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController timelineController = TextEditingController();

  void dialog(context){
    showDialog(context: context, builder: (BuildContext){
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Container(
          height: 120,
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  getCamera();
                  Navigator.pop(context);
                },
                child: ListTile(
                  leading: Icon(Icons.camera),
                  title: Text("Camera"),
                ),
              ),
              GestureDetector(
                onTap: (){
                  getGallery();
                  Navigator.pop(context);
                },
                child: ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text("Gallery"),
                ),
              )
            ],
          ),
        ),
      );
    },);
  }
  Future getCamera()async{
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if(pickedImage!=null){
        _image=File(pickedImage.path);
      }else{
        toastMassage("No image selected");
      }
    });
  }
  Future getGallery()async{
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if(pickedImage!=null){
        _image=File(pickedImage.path);
      }else{
        toastMassage("No image selected");
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showsipnner,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Add Your Bid"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    dialog(context);
                  },
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height*.2,
                      width: MediaQuery.of(context).size.width*.85,
                      child: _image != null?ClipRRect(
                        child: Image.file(
                          _image!.absolute,
                          height: 100,
                          width: 100,
                          fit: BoxFit.fitWidth,
                        ),
                      ):Container(
                        height: 100,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade100,
                        ),
                        child: Icon(Icons.camera_alt,color: Colors.blue,),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: titleController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: "Enter Bid Title",
                              labelText: "Bid Name",
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (String value){
                              title = value;
                            },
                            validator: ((value) {
                              return value!.isEmpty?'Enter Bid Name':null;
                            }),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: TextFormField(
                              controller: descriptionController,
                              minLines: 1,
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText: "Tell Something about your bid",
                                labelText: "Description",
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (String value){
                                description = value;
                              },
                              validator: ((value) {
                                return value!.isEmpty?'Tell something':null;
                              }),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(vertical: 15.0),
                          //   child: TextFormField(
                          //     controller: priceController,
                          //     keyboardType: TextInputType.number,
                          //     maxLines: 1,
                          //     decoration: InputDecoration(
                          //       hintText: "Set Your Product Primary Price ",
                          //       labelText: "Price",
                          //       border: OutlineInputBorder(),
                          //     ),
                          //     onChanged: (String value){
                          //       price = value as double;
                          //     },
                          //     validator: ((value) {
                          //       return value!.isEmpty?'Set Price':null;
                          //     }),
                          //   ),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(vertical: 15.0),
                          //   child: TextFormField(
                          //     controller: timelineController,
                          //     keyboardType: TextInputType.datetime,
                          //     maxLines: 1,
                          //     decoration: InputDecoration(
                          //       hintText: "Set Your Bid Timeline ",
                          //       labelText: "Last Date",
                          //       border: OutlineInputBorder(),
                          //     ),
                          //     onChanged: (String value){
                          //       timeline = value as DateTime;
                          //     },
                          //     validator: ((value) {
                          //       return value!.isEmpty?'Set a Date':null;
                          //     }),
                          //   ),
                          // ),

                          RoundButton(title: "Post", onpress: ()async{
                            if(_formKey.currentState!.validate()){
                              setState(() {
                                showsipnner = true;
                              });
                              try{
                                int date = DateTime.now().minute;
                                firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('/bff');
                                UploadTask uploadTask = ref.putFile(_image!.absolute);
                                await Future.value(uploadTask);
                                var newUrl = await ref.getDownloadURL();
                                User? user = _auth.currentUser;
                                _postref.child('Post List').child(date.toString()).set({
                                  'pId': date.toString(),
                                  'pImage': newUrl.toString(),
                                  'pTime': date.toString(),
                                  'pTitle': titleController.text.toString(),
                                  'pDescription': descriptionController.text.toString(),
                                  // 'pPrice': priceController.text.toString(),
                                  // 'pTimeline': timelineController.text.toString(),
                                  'uId': user!.uid.toString(),
                                }).then((value) {
                                  setState(() {
                                    showsipnner = false;
                                  });
                                  toastMassage("Post Published");
                                }).onError(
                                        (error, stackTrace) {
                                          toastMassage(error.toString());
                                          setState(() {
                                            showsipnner = false;
                                          });
                                        });
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
