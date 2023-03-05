import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:ustad/widget/round_button.dart';
import 'package:ustad/model/bid_description.dart';
import 'package:ustad/screens/add_post.dart';
import 'package:ustad/screens/bid_description.dart';

import '../methods.dart';
import '../widget/drawer.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dbRef = FirebaseDatabase.instance.ref('post');
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        title: Text("Ustad Auction"),
        centerTitle: true,
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AddPost.routeName);
              },
              child: Icon(Icons.add)),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
                query: dbRef.child('Post List'),
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Stack(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .25,
                                      width: MediaQuery.of(context).size.width,
                                      child: Image.network(
                                        snapshot
                                            .child('pImage')
                                            .value
                                            .toString(),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    Positioned(
                                      child: Container(
                                        width: MediaQuery.of(context).size.width*.03,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 25
                                            )
                                          ],
                                          color: Color(0xFFFFFFFF),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            snapshot
                                                .child('pTitle')
                                                .value
                                                .toString(),softWrap: false,
                                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900),
                                          ),
                                        ),

                                      ),
                                      left: 10,
                                      right: 200,
                                      bottom: 5,
                                    ),
                                    Positioned(
                                      child: GestureDetector(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width*.3,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 25
                                                )
                                              ],
                                              color: Color(0xFFFFFFFF),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Icon(Icons.shopping_cart_outlined),
                                                AutoSizeText(
                                                  '\$'+ snapshot.child('pPrice').value.toString(),
                                                  softWrap: false,
                                                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900),
                                                ),
                                              ],
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            ),
                                          ),

                                        ),
                                        onTap: (){
                                          String time = snapshot.child('pTimeline').value.toString();
                                          DateTime now = DateTime.now();
                                          DateTime bidTime = DateTime.parse(time);
                                          bidTime.compareTo(now)< 0? toastMassage("Time is Over"):dialog(context,snapshot.child('pId'));
                                        },
                                      ),
                                      right: 10,
                                      bottom: 5,
                                    ),

                                  ],
                                ),
                              ),
                              onTap: () {
                             Navigator.pushNamed(
                                  context,
                                  BidDescription.routeName,
                                  arguments: BidDes(
                                      title: snapshot
                                          .child('pTitle')
                                          .value
                                          .toString(),
                                      Description: snapshot
                                          .child('pDescription')
                                          .value
                                          .toString(),
                                      price: snapshot
                                          .child('pPrice')
                                          .value
                                          .toString(),
                                      imageUrl: snapshot
                                          .child('pImage')
                                          .value
                                          .toString(),
                                      bidList: snapshot.child('pId'),
                                    timeline: snapshot.child('pTimeline').value.toString(),
                                  ),
                                );
                              })),


                    ],
                  );
                }),
          )
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}

