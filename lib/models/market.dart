import 'package:flutter/material.dart';

class Market {
  String name;
  String logo;
  String image;
  int rating;
  int price;
  Market(
      {required this.image,
      required this.logo,
      required this.name,
      required this.rating,
      required this.price});
}
