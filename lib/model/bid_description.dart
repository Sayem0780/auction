import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class BidDes{
  final String title;
  final String Description;
  final String price;
  final String imageUrl;
  final DataSnapshot bidList;
  final String timeline;

  const BidDes({
    required this.title,required this.Description,required this.price,required this.imageUrl,required this.bidList,required this.timeline
  });

}