import 'package:flutter/material.dart';
import 'package:ustad/screens/add_post.dart';
class HomeScreen extends StatefulWidget {
  static const routeName ="/home screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Ustad Auction"),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.of(context).pushNamed(AddPost.routeName);
            },
              child: Icon(Icons.add)),
          SizedBox(width: 20,),
        ],
      ),
      body: Container(),
    );
  }
}
