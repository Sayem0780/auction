
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:ustad/methods.dart';
import 'package:ustad/model/bid_description.dart';
import 'package:auto_size_text/auto_size_text.dart';

class BidDescription extends StatefulWidget {
  static const routeName = '/product description';
  @override
  _BidDescriptionState createState() => _BidDescriptionState();
}

class _BidDescriptionState extends State<BidDescription> {
  
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as BidDes;
    final dbRef = FirebaseDatabase.instance.ref('post');
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Description'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .25,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(args.imageUrl), fit: BoxFit.fitWidth)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    args.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ), //Title
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    args.Description,
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25),
                  ), //Description
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Bids Table",
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*.35,
                    child: FirebaseAnimatedList(
                              query: dbRef.child('Bider List').child('BID').child(args.bidList.value.toString()),
                              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                                  Animation<double> animation, int index) {
                                if (args.bidList.value.toString() ==
                                    snapshot.child('bId').value.toString()) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      height: 60,
                                                      width: MediaQuery.of(context).size.width,
                                                    ),
                                                    Positioned(
                                                      child: Container(
                                                        width:
                                                            MediaQuery.of(context).size.width *
                                                                .5,
                                                        height: 40,
                                                        decoration: BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(blurRadius: 25)
                                                          ],
                                                          color: Color(0xFFFFFFFF),
                                                          borderRadius:
                                                              BorderRadius.circular(10),
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: AutoSizeText(
                                                              snapshot
                                                                  .child('biderEmail')
                                                                  .value
                                                                  .toString(),
                                                              softWrap: false,
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight: FontWeight.w900),
                                                            ),
                                                        ),
                                                      ),
                                                      left: 10,
                                                      bottom: 5,
                                                    ),
                                                    Positioned(
                                                        child: Container(
                                                          width: MediaQuery.of(context)
                                                                  .size
                                                                  .width * .3,
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(blurRadius: 25)
                                                            ],
                                                            color: Color(0xFFFFFFFF),
                                                            borderRadius:
                                                                BorderRadius.circular(20),
                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: AutoSizeText(
                                                              'Bid: \$' +
                                                                  snapshot
                                                                      .child('pBid')
                                                                      .value
                                                                      .toString(),
                                                              softWrap: false,
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight: FontWeight.w900),
                                                            ),
                                                          ),
                                                        ),
                                                      right: 10,
                                                      bottom: 5,
                                                    ),
                                                  ],
                                                ),
                                              ),

                                      )],
                                  );
                                } else {
                                  return Text("Hello ");
                                }
                              },
                            ),
                    ),
                  Container(
                    height: MediaQuery.of(context).size.height*.1,
                  )
                ],
              ),

          ),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_cart_outlined),
        onPressed: (){
          String time = args.timeline;
          DateTime now = DateTime.now();
          DateTime bidTime = DateTime.parse(time);
          bidTime.compareTo(now)< 0? toastMassage("Time is Over"):dialog(context, args.bidList);
        },
      ),
    );
  }
}
