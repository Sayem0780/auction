import 'package:flutter/material.dart';
class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onpress;
  RoundButton({required this.title,required this.onpress});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.antiAlias,
      child: MaterialButton(
        color: Colors.indigo,
        height: 50,
        minWidth: double.infinity,
        child: Text(title,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
        onPressed: onpress,
      ),
    );
  }
}
